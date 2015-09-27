<!doctype html>
<html>
  <head>
  <script>
function validateForm() {
    var x = document.forms["myForm"]["rating"].value;
    if (x>10 ) {
        alert("Rating should be less than 10");
        return false;
    }
}
</script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.5/angular.min.js"></script>
  </head>
  
  <body >
    <div class="header">
      <div class="container">
        <h1>MOVIE GOOD READS PORTAL</h1>
        <h2>Welcome <%= session.getAttribute("user") %></h2>
      </div>
    </div>

    <div class="container-fluid outerdiv" ng-app="myApp" ng-controller="MovieController">

  <noscript>
    <div class="nojs">Javascript is either disabled or not supported in your browser. Please enable it or use a Javascript enabled browser.</div>
  </noscript>

  <div class="animated zoomInRight">
    <div class="input-group search-bar">
     <strong><font size="4" color="blue">Enter the movie name here:</font> <input type="text" ng-model="search" ng-change="change()" onclick="select()" class="form-control" placeholder="Start your search for movies here" autofocus /><br><br>
      <span class="input-group-addon bar-style"><i class="glyphicon glyphicon-search"></i></span>
    </div>

    <div id="main-info" class="col-md-8">
      <div ng-if="!details">
        Loading results...
      </div>

      <div ng-if="details.Response==='True'">
        <img ng-src="{{ details.Poster=='N/A' ? 'http://placehold.it/150x220&text=N/A' : 'http://imdb.wemakesites.net/api/1.0/img/?url='+details.Poster }}" class="thumbnail animated flip movie-poster">
       
        <span class="span-outer">
       
          <a href="http://imdb.com/title/{{ details.imdbID }}" target="_blank">{{ details.Title }}</a>
        </span>, {{ details.Year }}
		<br>
         <p>----------------------------------------------------------------------------------------------------------</p>
         <br>
        <p><strong>Released on:</strong> {{ details.Released }} ({{ details.Runtime }})</p>

        <p class="outer-p">
          <div class="inner-p">
            <span class="label label-primary">Directors :</span> {{ details.Director }}
          </div>
          <div class="inner-p">
            <span class="label label-primary">Actors :</span> {{ details.Actors }}
          </div>
          <div class="inner-p">
            <span class="label label-primary">Genre :</span> {{ details.Genre }}
          </div>
        </p>
		<br>
         <p>----------------------------------------------------------------------------------------------------------</p>
         <br>
        <p class="outer-p-2">Ratings:
          <br>
          <strong>IMDb Rating</strong>: <span class="label label-success">{{ details.imdbRating }}</span>
          <br>
          <strong>Rotten Tomatoes</strong>: <span class="label label-success">{{ details.tomatoRating }}</span>
          <br>
          </p>
         
           <br><br>
      </div>
      <form action="Watched" method="post">
      <input type="hidden" name="uid1"  value=" <%= session.getAttribute("uid") %>" required>
         <input type="hidden" name="username" value=" <%= session.getAttribute("user") %>" required>  
         <input type="hidden" name="movie1"  value="{{ details.Title }}" required>
          <input type="submit" value="CHECK IF YOU HAVE WATCHED THE MOVIE ">
      </form>
		<p><strong><font size="10" color="red"> ${mov} ${error}</font></strong></p>
       <p>----------------------------------------------------------------------------------------------------------</p>
      
       <form action="PushIt" method="post" onsubmit="return validateForm()" name="myForm">
        	<input type="hidden" name="uid"  value=" <%= session.getAttribute("uid") %>" required>
         <input type="hidden" name="username"  value=" <%= session.getAttribute("user") %>" required> 
         <strong>Movie Name(Will Autofill if filled above)</strong>:<input type="text" name="movie"  value="{{ details.Title }}" required><br><br>
          <strong>Give your rating</strong>: <span class="label label-success"> <input type="text" name="rating" required></span><br><br>
          <strong>Date of watching the movie</strong>:<input type="text" name="date" value="20 Sep 2015" required><br><br>
         <input type="submit" value="SUBMIT MY RATING AND MARK THE FILM WATCHED">
         <br>
         <p>----------------------------------------------------------------------------------------------------------</p>
         <br>
        </form>
        <form action="Update" method="post">
        <input type="hidden" name="uid"  value=" <%= session.getAttribute("uid") %>" required>
         <input type="hidden" name="username" value=" <%= session.getAttribute("user") %>" required>  
          <strong>Movie Name(Will Autofill if filled above)</strong>:<input type="text" name="movie" id="movie_title" value="{{ details.Title }}" required><br>
          <strong>Recommend the movie to a person</strong>:<input type="text" name="recommend" value="none" required><br>
         <input type="submit" value="RECOMMEND THE MOVIE">
        </form>
      	<br>
      	 <br>
         <p>----------------------------------------------------------------------------------------------------------</p>
         <br>
       <a href="suggestions.jsp" >Click here to view your suggestions</a><br><br>
        <a href="othersuggestions.jsp">Click here to view suggestions to you and others</a><br><br>
       <br>
       <a href="index.jsp"><strong>Logout</strong></a>
         <p>----------------------------------------------------------------------------------------------------------</p>
         <br>
      <div ng-if="details.Response==='False'">
        No related-results found.
      </div>
    </div>
    <div id="related-results" class="col-md-4 animated bounce related-results">
      <div ng-if="related.Response!=='False'">
        Related Results:
        <hr>

        <ul class="rel-results">
          <li ng-repeat="movie in related.Search">
            <a href="#" id="{{ $index + 1 }}" ng-click="update(movie)">{{ movie.Title }}</a>, {{ movie.Year }}
          </li>
        </ul>
      </div>
    </div>
  </div>
</div> 
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>
<% 

java.sql.Connection con;
java.sql.Statement s;
java.sql.ResultSet rs;
java.sql.PreparedStatement pst;

con=null;
s=null;
pst=null;
rs=null;


// Remember to change the next line with your own environment 
String url= "jdbc:mysql://localhost:3306/sourcecode";
String id= "root";
String pass = "1234";
try{

Class.forName("com.mysql.jdbc.Driver");
con = java.sql.DriverManager.getConnection(url, id, pass);

}catch(ClassNotFoundException cnfex){
cnfex.printStackTrace();
}
int uid1 = Integer.parseInt((String)request.getSession().getAttribute("uid"));
String sql= "select movie,rating,date from people where uid="+uid1;

try{
s = con.createStatement();
rs = s.executeQuery(sql);

%>
<h><font size="10" color="blue">Movies watched by you and their ratings:</font></h>
<%
while( rs.next() ){
%>
							<p><strong><%= rs.getString(1)%></strong> </p>
							<p>Rating:<%= rs.getString(2) %><br>Watched On: <%= rs.getString(3) %><br></p><%
}
%>
<% 

}
catch(Exception e){e.printStackTrace();}
finally{
if(rs!=null) rs.close();
if(s!=null) s.close();
if(con!=null) con.close();
}

%>





    <!-- Controllers -->
    <script>
    'use strict';

    angular.module('myApp', [])
      .controller('MovieController', function($scope, $http) {
        var pendingTask;

        if ($scope.search === undefined) {
          $scope.search = "";
          fetch();
        }

        $scope.change = function() {
          if (pendingTask) {
            clearTimeout(pendingTask);
          }
          pendingTask = setTimeout(fetch, 800);
        };

        function fetch() {
          $http.get("http://www.omdbapi.com/?t=" + $scope.search + "&tomatoes=true&plot=full")
            .success(function(response) {
              $scope.details = response;
            });

          $http.get("http://www.omdbapi.com/?s=" + $scope.search)
            .success(function(response) {
              $scope.related = response;
            });
        }

        $scope.update = function(movie) {
          $scope.search = movie.Title;
          $scope.change();
        };

        $scope.select = function() {
          this.setSelectionRange(0, this.value.length);
        }
      });

    </script>
    
  </body>
</html>
