<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加目标指标配置</title>
    <!--引入抽取css文件-->
    <%@include file="../../common/public-css.jsp" %>
</head>
<body>
<div style="margin: 15px;">
    <blockquote class="layui-elem-quote">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;表单带有 <span class="font-red">“*”</span> 号的为必填项.
        <span style="color: red; font-weight: bold; font-size: 16px;">&nbsp;&nbsp;务必请为每一个部门添加权重和为100的各项指标</span>
    </blockquote>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>添加目标指标配置</legend>
    </fieldset>
    <form class="layui-form" action="" id="formData">

        <div class="layui-form-item">
            <label class="layui-form-label">选择公司<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select id="companyId" name="companyId" lay-filter="company" lay-search="" lay-verify="required">
                    <option value="">选择或搜索公司</option>
                    <option value="0" disabled>暂无</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item layui-hide">
            <label class="layui-form-label">选择部门<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select id="departmentId" name="departmentId" lay-filter="departmentId" lay-search="" lay-verify="required">
                    <option value="">选择或搜索部门</option>
                    <option value="0" disabled>暂无</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">指标名称<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="targetName" lay-verify="required" placeholder="请输入指标名称" autocomplete="off" class="layui-input" maxlength="50">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">指标权重<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="number" name="targetWeight" lay-verify="required|isDouble" placeholder="请输入指标权重" autocomplete="off" class="layui-input" maxlength="10">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">指标值描述<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <textarea name="targetMsg" lay-verify="required" placeholder="请输入指标值描述" autocomplete="off" class="layui-textarea" maxlength="200"></textarea>
            </div>
        </div>

        <div class="layui-form-item layui-hide">
            <label class="layui-form-label">针对时间类型<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <select name="timeType">
                    <option value="">请选择</option>
                    <option value="0">周</option>
                    <option value="1">月</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">针对月份<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="targetTime" lay-verify="required" placeholder="请选择针对月份" onfocus="WdatePicker({dateFmt:'yyyy-MM'})"  autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">是否是项目部<span class="font-red">*</span></label>
            <div class="layui-input-block">
                <input type="checkbox" name="isProjectDepartment" lay-skin="switch" title="开关" lay-text="是|否" lay-filter="isProjectDepartment">
            </div>
        </div>

        <div class="layui-form-item layui-hide">
            <label class="layui-form-label">目标结项数<span class="font-red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="targetNum" lay-verify="" onkeyup="YZ.clearNoNum(this)" onblur="YZ.clearNoNum(this)" placeholder="请输入目标结项数" autocomplete="off" class="layui-input" maxlength="10">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<!--引入抽取公共js-->
<%@include file="../../common/public-js.jsp" %>
<script>
    var isProjectDepartment = YZ.getUrlParam("isProjectDepartment");
    layui.use(['form', 'layedit', 'laydate'], function() {
        var form = layui.form(),
                layer = layui.layer,
                laydate = layui.laydate;

        getCompanyListType(null, 0);

        //自定义验证规则
        form.verify({
            isDouble: function(value) {
                if(value.length > 0 && !YZ.isDouble.test(value)) {
                    return "请输入一个整数或小数";
                }
            },
            isZero : function (value) {
                if(value < 0 || value > 100) {
                    return "请输入(0-100)";
                }
            }
        });

        //公司过滤器
        form.on('select(company)', function(data){
            console.log(data);
            getDepartmentListType(Number(data.value), null, isProjectDepartment, 0);
            form.render();
        });

        form.on("switch(isProjectDepartment)", function (data) {
            console.log(data);
            if (data.elem.checked) {
                $("input[name='targetNum']").attr("lay-verify", "required|isDouble");
                $("input[name='targetNum']").parent().parent().show();
            }
            else {
                $("input[name='targetNum']").removeAttr("lay-verify");
                $("input[name='targetNum']").parent().parent().hide();
            }
            form.render();
        });
        form.render();

        //监听提交
        form.on('submit(demo1)', function(data) {
            console.log(data);
            data.field.timeType = 1;
            data.field.isProjectDepartment = data.field.isProjectDepartment == "on" ? 1 : 0;
            data.field.targetTime = new Date(data.field.targetTime);
            console.log(data.field);

            YZ.ajaxRequestData("post", false, YZ.ip + "/secondTarget/addSecondTarget", data.field , null , function(result) {
                if (result.flag == 0 && result.code == 200) {
                    layer.alert('添加成功.', {
                        skin: 'layui-layer-molv' //样式类名
                        ,closeBtn: 0
                        ,anim: 3 //动画类型
                    }, function(){
                        //关闭iframe页面
                        var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                        parent.layer.close(index);
                        window.parent.closeNodeIframe();
                    });
                }
            });
            return false;
        });
    });
</script>
</body>
</html>
