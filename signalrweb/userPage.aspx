<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="userPage.aspx.cs" Inherits="signalrWeb.userPage" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的SIGNALR应用程序</title>
    <script src="Scripts/jquery-3.4.1.js"></script>
    <script src="Scripts/jquery.signalR-2.4.1.js"></script>
    <%--  @*<script src="http://localhost:8889/signalr/hubs"></script>*@--%>
    <script src="https://localhost:44367/signalr/hubs"></script>
    <script>
        $(document).ready(function () {
            var chat = $.connection.chatHub;

            $('#displayname').val(prompt('你的聊天访客名:', ''));

            chat.client.broadcastMessage = function (name, message) {
                //在页面中追加并显示聊天信息
                $('#discussion').append(name + ':  ' + message + '' + '</br>');
            };
            $('#message').focus();
            // 与服务器建立连接
            $.connection.hub.start().done(function () {
                $('#sendmessage').click(function () {
                    // 调用服务器方法
                    chat.server.send($('#displayname').val(), $('#message').val());
                    // 清空消息输入框
                    $('#message').val('').focus();
                });
            });
        });
    </script>
</head>
<body>
    <h2>User page<label id="rstart"></label></h2>
    <div>
        <div class="container">
            <input type="text" id="message" />
            <input type="button" id="sendmessage" value="Send" />
            <input type="text" id="displayname" />
            <ul id="discussion"></ul>
        </div>
    </div>
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>

            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                </ul>
            </div>
        </div>
    </div>
    <div class="container body-content">
        <hr />
        <footer>
         
        </footer>
    </div>
</body>
</html>
