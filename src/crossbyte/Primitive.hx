package crossbyte;

/**
 * An abstract type representing a generic primitive value.
 *
 * This abstract provides seamless conversion between `String`, `Int`, `Float`, and `Bool`,
 * allowing for flexible handling of primitive types.
 *
 * ## Supported Types:
 * - `String`
 * - `Int`
 * - `Float`
 * - `Bool`
 *
 * ## Example:
 * ```haxe
 * var p:Primitive = 42;
 * var s:String = p; // Automatic conversion to "42"
 * var b:Bool = p.toBool(); // true
 * ```
 */
abstract Primitive(Any) from Dynamic to Dynamic {

    /**
     * Converts the primitive to a `String`.
     * @return The string representation of the primitive.
     */
    @:to public inline function toString():String {
        return Std.string(this);
    }

    /**
     * Converts the primitive to an `Int`.
     * 
     * - Strings are parsed as integers.
     * - `true` becomes `1`, `false` becomes `0`.
     * - `null` converts to `0`.
     *
     * @return The integer representation of the primitive.
     * @throws If conversion is not possible.
     */
    @:to public inline function toInt():Int {
        switch (Type.typeof(this)) {
            case TInt, TFloat:
                return this;
            case TBool:
                return this ? 1 : 0;
            case TClass(String):
                return Std.parseInt(this);
            case TNull:
                return 0;
            default:
                throw "Cannot convert " + Std.string(this) + " to Int";
        }
    }

    /**
     * Converts the primitive to a `Float`.
     * 
     * - Strings are parsed as floats.
     * - `true` becomes `1.0`, `false` becomes `0.0`.
     * - `null` converts to `0.0`.
     *
     * @return The float representation of the primitive.
     * @throws If conversion is not possible.
     */
    @:to public inline function toFloat():Float {
        switch (Type.typeof(this)) {
            case TInt, TFloat:
                return this;
            case TBool:
                return this ? 1.0 : 0.0;
            case TClass(String):
                return Std.parseFloat(this);
            case TNull:
                return 0.0;
            default:
                throw "Cannot convert " + Std.string(this) + " to Float";
        }
    }

    /**
     * Converts the primitive to a `Bool`.
     * 
     * - `0` or `0.0` converts to `false`, anything else is `true`.
     * - Strings convert to `true` unless they are `"false"`.
     * - `null` converts to `false`.
     *
     * @return The boolean representation of the primitive.
     * @throws If conversion is not possible.
     */
    @:to public inline function toBool():Bool {
        switch (Type.typeof(this)) {
            case TInt:
                return this != 0;
            case TFloat:
                return this != 0.0;
            case TBool:
                return this;
            case TClass(String):
                return this != "false";
            case TNull:
                return false;
            default:
                throw "Cannot convert " + Std.string(this) + " to Bool";
        }
    }

    /**
     * Creates a `Primitive` from a `String`.
     * 
     * @param s The string value.
     * @return A `Primitive` instance.
     */
    @:from public static inline function fromString(s:String):Primitive {
        return s != null ? s : "";
    }

    /**
     * Creates a `Primitive` from an `Int`.
     * 
     * @param i The integer value.
     * @return A `Primitive` instance.
     */
    @:from public static inline function fromInt(i:Int):Primitive {
        return i;
    }

    /**
     * Creates a `Primitive` from a `Float`.
     * 
     * - `NaN` values are converted to `0.0`.
     *
     * @param f The float value.
     * @return A `Primitive` instance.
     */
    @:from public static inline function fromFloat(f:Float):Primitive {
        return !Math.isNaN(f) ? f : 0.0;
    }

    /**
     * Creates a `Primitive` from a `Bool`.
     * 
     * @param b The boolean value.
     * @return A `Primitive` instance.
     */
    @:from public static inline function fromBool(b:Bool):Primitive {
        return b;
    }

    /**
     * Checks if a given value is a valid primitive type.
     * 
     * @param value The value to check.
     * @return `true` if the value is a `String`, `Int`, `Float`, or `Bool`, otherwise `false`.
     */
    public static function isValid(value:Dynamic):Bool {
        return value != null
            && (Std.isOfType(value, String) || Std.isOfType(value, Int) || Std.isOfType(value, Float) || Std.isOfType(value, Bool));
    }
}