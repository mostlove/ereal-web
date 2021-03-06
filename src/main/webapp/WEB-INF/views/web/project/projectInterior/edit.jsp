<!-- 解决layer.open 不居中问题   -->
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>修改内部项目</title>
    <!--引入抽取css文件-->
    <%@include file="../../common/public-css.jsp" %>
</head>
<body ng-app="webApp">
    <div style="margin: 15px;">
        <blockquote class="layui-elem-quote"><i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;表单带有 <span class="font-red">“*”</span> 号的为必填项.</blockquote>
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>修改内部项目</legend>
        </fieldset>
        <form class="layui-form" action="" id="formData" ng-controller="projectInteriorEditCtr" ng-cloak>

            <div class="layui-form-item ">
                <label class="layui-form-label">选择部门<span class="font-red">*</span></label>
                <div class="layui-input-inline">
                    <select id="departmentId" name="departmentId"  lay-search="" lay-verify="required">
                        <option value="">选择或搜索部门</option>
                        <option value="0" disabled>暂无</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item ">
                <label class="layui-form-label">选择A导师<span class="font-red">*</span></label>
                <div class="layui-input-inline">
                    <select id="companyId" name="companyId" lay-filter="companyFilter" lay-search="" >
                        <option value="">选择或搜索公司</option>
                        <option value="0" disabled>暂无</option>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <select id="department" name="department" lay-filter="departmentFilter" lay-search="" >
                        <option value="">选择或搜索部门</option>
                        <option value="0" disabled>暂无</option>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <select id="allocationUserId" name="allocationUserId"  lay-search="" lay-verify="required">
                        <option value="">选择或搜索A导师</option>
                        <option value="0" disabled>暂无</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item layui-hide">
                <label class="layui-form-label">选择项目组<span class="font-red">*</span></label>
                <div class="layui-input-inline">
                    <select name="projectGroupId" lay-verify="" lay-search="">
                        <option value="">请选择或搜索项目组</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item ">
                <label class="layui-form-label">直接汇报人<span class="font-red">*</span></label>
                <div class="layui-input-inline">
                    <select name="directReportPersonUserIdCompanyId" lay-filter="directReportPersonUserIdCompanyIdFilter"   lay-search="">
                        <option value="">请选择或搜索公司</option>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <select name="directReportPersonUserIdDepartment"lay-filter="directReportPersonUserIdDepartmentFilter"   lay-search="">
                        <option value="">请选择或搜索部门</option>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <select name="directReportPersonUserId" lay-verify="required" lay-search="">
                        <option value="">请选择或搜索直接汇报人</option>
                    </select>
                </div>
            </div>



            <div class="layui-form-item" ng-hide="isDisabled == 0">
                <label class="layui-form-label">项目编号<span class="font-red">*</span></label>
                <div class="layui-input-inline">
                    <input type="text" value="{{projectInteriorInfo.projectNumber}}" name="projectNumber" lay-verify="required" placeholder="请输入项目编号" autocomplete="off" class="layui-input" maxlength="20">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">项目名<span class="font-red">*</span></label>
                <div class="layui-input-inline">
                    <input type="text" value="{{projectInteriorInfo.projectName}}" name="projectName" lay-verify="required" placeholder="请输入项目名" autocomplete="off" class="layui-input" maxlength="20">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">项目简称<span class="font-red">*</span></label>
                <div class="layui-input-inline">
                    <input type="text" value="{{projectInteriorInfo.shortName}}" name="shortName" lay-verify="required" placeholder="请输入项目简称" autocomplete="off" class="layui-input" maxlength="20">
                </div>
            </div>

            <div class="layui-form-item" ng-hide="isDisabled == 0">
                <label class="layui-form-label">选择内部项目专业<span class="font-red">*</span></label>
                <div class="layui-input-inline">
                    <select name="projectMajorId" lay-verify="required" lay-search="">
                        <option value="">请选择或搜索内部项目专业</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item" ng-hide="isDisabled == 0">
                <label class="layui-form-label">初始工作量<span class="font-red">*</span></label>
                <div class="layui-input-inline">
                    <input type="text" value="{{projectInteriorInfo.initWorkload}}" disabled name="initWorkload" lay-verify="required|isNumber|isZero" placeholder="请输入初始工作量" autocomplete="off" class="layui-input" maxlength="3">
                </div>
                <div class="layui-form-mid layui-word-aux">单位为: 天</div>
            </div>

            <div class="layui-form-item" ng-hide="isDisabled == 0">
                <label class="layui-form-label">项目启动时间<span class="font-red">*</span></label>
                <div class="layui-input-inline">
                    <input type="text" value="{{ projectInteriorInfo.startTime | date:'yyyy-MM-dd'}}" name="startTime" lay-verify="required" placeholder="项目启动时间" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this, min: '2010-01-01 00:00:00'})" readonly>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">项目截止时间<span class="font-red">*</span></label>
                <div class="layui-input-inline">
                    <input type="text" value="{{ projectInteriorInfo.endTime | date:'yyyy-MM-dd'}}" name="endTime" lay-verify="required" placeholder="项目截止时间" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})" readonly>
                </div>
            </div>

            <div class="layui-form-item" ng-hide="isDisabled == 0">
                <label class="layui-form-label">选择类型</label>
                <div class="layui-input-block" id="isForeign">
                    <input type="radio" name="atHome" value="0" title="对内">
                    <input type="radio" name="atHome" value="1" title="对外">
                    <%--<span ng-if="projectInteriorInfo.atHome == 0">
                        <input type="checkbox" name="atHome" lay-skin="switch" lay-filter="switchTest" lay-text="是|否">
                    </span>
                    <span ng-if="projectInteriorInfo.atHome == 1">
                        <input type="checkbox" name="atHome" lay-skin="switch" lay-filter="switchTest" lay-text="是|否" checked>
                    </span>--%>
                </div>
                <%--<div class="layui-form-mid layui-word-aux">默认添加对内，开启则是对外</div>--%>
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


        var webApp=angular.module('webApp',[]);
        webApp.controller("projectInteriorEditCtr", function($scope,$http,$timeout){
            $scope.projectInteriorId = YZ.getUrlParam("projectInteriorId");
            $scope.isDisabled = YZ.getUrlParam("isDisabled");
            $scope.projectInteriorInfo = null;
            YZ.ajaxRequestData("get", false, YZ.ip + "/projectInterior/info", {id : $scope.projectInteriorId}, null , function(result){
                if(result.flag == 0 && result.code == 200){
                    $scope.projectInteriorInfo = result.data;
                }
            });

            layui.use(['layer', 'form', 'layedit', 'laydate', 'element'], function() {
                var form = layui.form(),
                        layer = layui.layer,
                        laydate = layui.laydate;

//                getDirectReportPersonUser($scope.projectInteriorInfo.companyId, $scope.projectInteriorInfo.departmentId, $scope.projectInteriorInfo.directReportPersonUserId);
////                getAllForWebGroup($scope.projectInteriorInfo.departmentId);
//                queryDepartmentByCompany($scope.projectInteriorInfo.departmentId,"departmentId",1,null,null);
//                getProjectMajorList($scope.projectInteriorInfo.projectMajorId);


                queryDepartmentByCompany(null == $scope.projectInteriorInfo.departmentId ? 0 :
                        $scope.projectInteriorInfo.departmentId,"departmentId",1,null,null);
                queryAllCompany(0,"companyId",1);
                queryAllCompany(0,"directReportPersonUserIdCompanyId",1);
                queryUserByDepartment(null == $scope.projectInteriorInfo.allocationUserId ?
                        0 : $scope.projectInteriorInfo.allocationUserId,"allocationUserId",1,null,null,null);
                queryUserByDepartment(null == $scope.projectInteriorInfo.directReportPersonUserId ?
                        0 : $scope.projectInteriorInfo.directReportPersonUserId,"directReportPersonUserId",1,null,null,null);
//
//
                getProjectMajorList(null == $scope.projectInteriorInfo.projectMajorId ? 0 : $scope.projectInteriorInfo.projectMajorId);

                //选中性别
                $("input[name='atHome']").each(function () {
                    if (Number($(this).val()) == Number($scope.projectInteriorInfo.atHome)) {
                        $(this).click();
                    }
                });

                /*var isHtml = "";
                if ($scope.projectInteriorInfo.atHome == 0) {
                    isHtml = "<input type=\"checkbox\" name=\"atHome\" lay-skin=\"switch\" lay-filter=\"switchTest\" lay-text=\"是|否\">";
                }
                else {
                    isHtml = "<input type=\"checkbox\" name=\"atHome\" lay-skin=\"switch\" lay-filter=\"switchTest\" lay-text=\"是|否\" checked>";
                }
                $("#isForeign").html(isHtml);*/

                //自定义验证规则
                form.verify({
                    isNumber: function(value) {
                        if(value.length > 0 && !YZ.isNumber.test(value)) {
                            return "请输入一个整数";
                        }
                    },
                    isZero : function (value) {
                        if(value <= 0) {
                            return "不能小于等于0";
                        }
                    }
                });

                form.on('select(directReportPersonUserIdCompanyIdFilter)', function(data) {
                    getDepartmentListOfCTeacher (data.value,null,0);
                    form.render();
                });

                form.on('select(directReportPersonUserIdDepartmentFilter)', function(data) {
                    getDepartmentIdUserOfCTeacher (data.value,null,0);
                    form.render();
                });

                // 选择A导师的时候 触发的公司选择器
                form.on('select(companyFilter)', function(data) {
                    getDepartmentListOfProject(data.value,null,0);
                    form.render();
                });

                // 选择A导师的时候 触发的部门选择器
                form.on('select(departmentFilter)', function(data) {
                    getDepartmentIdUserOfProject(data.value,null,0);
                    form.render();
                });

                form.on('select(department)', function(data) {
                    getDirectReportPersonUser(data.elem[data.elem.selectedIndex].title, data.value, 0);
                    form.render();
                });

                form.render();
                //监听提交
                form.on('submit(demo1)', function(data) {
                    data.field.startTime = new Date(data.field.startTime);
                    data.field.endTime = new Date(data.field.endTime);
                    //data.field.atHome = data.field.atHome == undefined ? 0 : 1;
                    data.field.id = $scope.projectInteriorId;
                    delete data.field.department;
                    console.log(data.field);
                    YZ.ajaxRequestData("post", false, YZ.ip + "/projectInterior/update", data.field , null , function(result) {
                        if (result.flag == 0 && result.code == 200) {
                            layer.alert('修改内部项目成功.', {
                                skin: 'layui-layer-molv' //样式类名
                                ,closeBtn: 0
                                ,anim: 4 //动画类型
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

        });

        //获取内部项目专业
        function getProjectMajorList (selectId) {
            YZ.ajaxRequestData("get", false, YZ.ip + "/projectMajor/list", {}, null , function(result){
                if(result.flag == 0 && result.code == 200){
                    var html = "<option value=\"\">请选择或搜索内部项目专业</option>";
                    for (var i = 0; i < result.data.length; i++) {
                        if (result.data[i].id == selectId) {
                            html += "<option selected=\"selected\" value=\"" + result.data[i].id + "\">" + result.data[i].majorName + "</option>";
                        }
                        else {
                            html += "<option value=\"" + result.data[i].id + "\">" + result.data[i].majorName + "</option>";
                        }
                    }
                    if (result.data.length == 0) {
                        html += "<option value=\"0\" disabled>暂无</option>";
                    }
                    $("select[name='projectMajorId']").html(html);
                }
            });
        }

        //获取直接汇报人
        function getDirectReportPersonUser (companyId, departmentId, selectId) {
            if(null == companyId && null == departmentId){
                return;
            }
            YZ.ajaxRequestData("get", false, YZ.ip + "/user/queryUserForWeb", {companyId : companyId,departmentId:departmentId}, null , function(result){
                if(result.flag == 0 && result.code == 200){
                    var html = "<option value=\"\">请选择或搜索直接汇报人</option>";
                    for (var i = 0; i < result.data.length; i++) {
                        if (result.data[i].id == selectId) {
                            html += "<option selected=\"selected\" value=\"" + result.data[i].id + "\">" + result.data[i].name + "</option>";
                        }
                        else {
                            html += "<option value=\"" + result.data[i].id + "\">" + result.data[i].name + "</option>";
                        }
                    }
                    if (result.data.length == 0) {
                        html += "<option value=\"0\" disabled>暂无</option>";
                    }
                    $("select[name='directReportPersonUserId']").html(html);
                    $("select[name='directReportPersonUserId']").parent().parent().show();
                }
            });
        }


    </script>
</body>
</html>
