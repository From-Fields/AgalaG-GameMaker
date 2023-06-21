/// @description Insert description here
// You can write your code in this editor

// Movement Methods
DoScale = function() {
    if(!_doScale)
        return;

    var targetScale = (_scaleUp) ? new Vector2(1, 1).Multiply(_maximumScale) : new Vector2(1, 1);
	var _scaleX = targetScale._x;
	var _scaleY = targetScale._y;
	
	var _dt = delta_time / 1000000;

    image_xscale = lerp(image_xscale, _scaleX, _dt * _scaleSpeed);
    image_yscale = lerp(image_yscale, _scaleY, _dt * _scaleSpeed);

    if(abs(image_xscale - _scaleX) <= 0.05)
        _scaleUp = !_scaleUp;
}
DoRotation = function() {
    if(!_rotate)
        return;

	var _dt = delta_time / 1000000;
	
	rotation_ = image_angle + _rotationSpeed * _dt;
    rotation_ = new MathF().Repeat(rotation_, 360);
    // System.Diagnostics.Debug.WriteLine(rotation_);

    image_angle = rotation_;
}

DoRotation();
DoScale();

