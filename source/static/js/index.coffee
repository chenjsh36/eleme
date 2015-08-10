console.log("hello cjs!");
# obj declare ##########################
# pic_show = (name, nums, ul_h) -> 
# 	this.item_n = nums;
# 	this.height = ul_h;
# 	this.current = 0;
# 	this.pic_show = document.getElementsByClassName(name)[0];

# pic_show.prototype.show = (index) ->
# 	this.current = index;
# 	_offset_h = - (index * this.height);
# 	this.pic_show.style.transform = "translate(0, " + _offset_h + "px)";
class Pic_show
	constructor : (name, nums, ul_h) ->
		@item_n = nums
		@height = ul_h
		@current = 0
		@pic_show = document.getElementsByClassName(name)[0]
	show: (index) ->
		alert("click" + index)
		@current = index
		_offset_h = -(index * @height)
		@pic_show.style.transform = "translate(0, " + _offset_h + "px)"

# function ############################## 


#  event ################################
# $pic_show = document.querySelectorAll(".pic-show ul li");
$pic_show = document.getElementsByClassName("pic-show");
console.log("pic_show.innerHtml: " + $pic_show[0].innerHTML);

# _h = $pic_show[0].style.height;
# _h = $pic_show[0].currentStyle["height"] || window.getComputedStyle($pic_show[0], "height");
if $pic_show[0].currentStyle
	_h = $pic_show[0].currentStyle["height"]
else if window.getComputedStyle
	_h = window.getComputedStyle($pic_show[0],null)["height"]


_nums = $pic_show.length;
console.log("height : " + _h + " ane nums : " + _nums);

$window_pic_show = new Pic_show("pic-show", _nums, _h);


# $pic_ols = document.querySelectorAll(".pic-show ol li");
# _pic_show = document.getElementsByClassName(".pic-show")[0];
_ol = document.getElementsByTagName("ol")[0]
# console.log(_ol.innerHTML);
$pic_ols = _ol.childNodes;
console.log("lenght" + $pic_ols.length);

for li, i in $pic_ols
	# console.log(li + " " + i);
	index = li.innerText
	console.log(index)
	li.addEventListener("click", ()->
		alert("click");
		$window_pic_show.show(@.innerText)
	)
	# li.addEventListener("")
# for (i = 0, len = $pic_ols.length; i < len; i++) 
# 	$pic_ols.addEventListener("onclick", (i)->
# 		alert("ok")
# 	)(i);



