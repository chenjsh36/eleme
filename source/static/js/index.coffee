console.log("hello cjs!");
# function =====================================================================================#
addClass = (obj, className) ->
	_old_classname = obj.className.trim()
	_old_classname = if _old_classname == "" then " " else " " + _old_classname + " "
	if (_old_classname.indexOf(" " + className + " ") == -1)
		_old_classname += className + " "
	obj.className = _old_classname    
	console.log("addClass:" + obj.className)

removeClass = (obj, className) ->
	_old_classname = obj.className.trim()
	_old_classname = if _old_classname == "" then " " else " " + _old_classname + " "
	if (_old_classname.indexOf(" " + className + " ") != -1)
		"have"
		_old_classname = _old_classname.replace(" " + className + " ", " ")
	obj.className = _old_classname
	console.log("reomve : " + obj.className)

toggleClass = (obj, className) ->
	_old_classname = obj.className.trim()
	_old_classname = if _old_classname == "" then " " else " " + _old_classname + " "
	if (_old_classname.indexOf(" " + className + " ") != -1)
		_old_classname = _old_classname.replace(" " + className + " ", " ")
	else 
		_old_classname += className + " "
	obj.className = _old_classname

getStyle = (obj, styleName) ->
	if obj.currentStyle
		_s = obj.currentStyle[styleName]
	else if window.getComputedStyle
		_s = window.getComputedStyle(obj,null)[styleName]
	_s
# obj declare =====================================================================================#

###
# 定义图片滚动类
# name：图片列表的ul类名
# height：包含图片的li高度
# current：当前显示的图片索引号0开始
# picshow(index) : 显示第index张图片
###
class Pic_show
	constructor : (name, nums, ul_h) ->
		console.log("ul_h" + ul_h)
		@name = name
		@item_n = nums
		@height = parseInt(ul_h)
		@current = 0
		@pic_show_ol = document.getElementsByClassName(name+'-ol')[0]
		@pic_show = document.getElementsByClassName(name+'-ul')[0]
	show: (index) ->
		@current = index - 1
		_offset_h = -(@current * @height)
		@pic_show.style['transform'] = @pic_show.style['-webkit-transform'] = "translate(0, " + _offset_h + "px)"
	toggle: (index) ->
		@current = index - 1
		_ols = @pic_show_ol.childNodes
		console.log(_ols.length)
		for li, i in _ols
			removeClass(li, "active")
		addClass(_ols[@current], "active")
		
class Taps_select
	constructor : (select_name, content_name) ->
		@taps_select = document.getElementsByClassName(select_name)
		@taps_content = document.getElementsByClassName(content_name)
		@length = @taps_content.length
		console.log("content_len : " + @taps_select.length)
		@current = 0
	show: (index) ->
		console.log(index)
		if index <= @length
			for li, i in @taps_content
				removeClass(li, "active")
				removeClass(@taps_select[i], "active")
			addClass(@taps_select[index-1], "active")
			addClass(@taps_content[index-1], "active")

#  event =====================================================================================#
# 图片滑块
$pic_show = document.getElementsByClassName("pic-show");

if $pic_show[0].currentStyle
	_h = $pic_show[0].currentStyle["height"]
else if window.getComputedStyle
	_h = window.getComputedStyle($pic_show[0],null)["height"]
_nums = $pic_show.length;
$window_pic_show = new Pic_show("pic-show", _nums, _h);

_ol = document.getElementsByTagName("ol")[0]
$pic_ols = _ol.childNodes;

for li, i in $pic_ols
	index = li.innerText
	console.log(index)
	li.addEventListener("click", ()->
		$window_pic_show.show(@.innerText)
		$window_pic_show.toggle(@.innerText)
	)


# 内容块切换
$sidebar = document.getElementById("sidebar");
$taps_select = document.getElementsByClassName("taps-selects-item")
$taps_content = document.getElementsByClassName("taps-contents")
$tap = new Taps_select("taps-selects-item", "taps-contents")
for s, i in $taps_select
	s.addEventListener("click", () ->
		$tap.show(@.title)
	)


# 边栏切换
$show_sid_bar = document.getElementById("show-side-bar")
$topbar = document.getElementById("topbar")
$content = document.getElementById("content")
$footer = document.getElementById("footer")
$show_sid_bar.addEventListener("click", ()->
		toggleClass($sidebar, "active")
	)
$topbar.addEventListener("click", ()->
		removeClass($sidebar, "active");
	)
$content.addEventListener("click", ()->
		removeClass($sidebar, "active");
	)
$footer.addEventListener("click", ()->
		removeClass($sidebar, "active");
	)


# 提示块显示
$best_box_container = document.getElementsByClassName("best-game-contents")[0].getElementsByClassName("box-container")
$best_propover = document.getElementsByClassName("best-game-contents")[0].getElementsByClassName("propover")[0]

_box_w = parseInt(getStyle($best_box_container[0], "width"));
_prover_w = parseInt(getStyle($best_propover, "width"));

for box, i in $best_box_container
	box.alt = i
	box.addEventListener("mouseenter", (e)->
			# console.log("mouseenter:" + e.pageX + " " + e.pageY)
			console.log("clint_h:" + window.innerHeight + "clint_w" + window.innerWidth)
			# console.log("box : " + getStyle(@, "width") + " " +getStyle(@, "offsetTop") + " " + getStyle(@, "offsetLeft"))
			# console.log("@.alt : " + @.alt)
			_left = _box_w * (@.alt + 1)
			# console.log("asdf:" + parseInt(e.pageX / _box_w))
			if (_left + _prover_w <= window.innerWidth)
				$best_propover.style.left = _left + "px"
				$best_propover.style.display = "block"
				removeClass($best_propover, "right")
				addClass($best_propover, "left")
			else
				_left -= _box_w + _prover_w
				if _left >= 0
					$best_propover.style.left = _left + "px"
					$best_propover.style.display = "block"
					removeClass($best_propover, "left")
					addClass($best_propover, "right")
			# console.log(getStyle($best_propover, "left"))

	)
	box.addEventListener("mouseleave", (e)->
			# console.log("mouseenter:" + e.pageX + " " + e.pageY)
			# console.log("clint_h:" + window.innerHeight + "clint_w" + window.innerWidth)
			# console.log("box : " + getStyle(@, "width") + " " +getStyle(@, "offsetTop") + " " + getStyle(@, "offsetLeft"))
			# console.log("@.alt : " + @.alt)
			# _left = _box_w * (@.alt + 1)
			# console.log("asdf:" + parseInt(e.pageX / _box_w))
			# $best_propover.style.left = _left + "px"
			$best_propover.style.display = "none"
			# console.log(getStyle($best_propover, "left"))

	)

