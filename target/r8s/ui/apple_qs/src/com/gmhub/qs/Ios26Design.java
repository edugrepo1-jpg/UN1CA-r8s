package com.gmhub.qs;

/** Measured geometry for the iOS 26 reference, independent of rendering and
 * native control ownership. The official guide shows circular one-cell buttons,
 * capsule sliders/pills, rounded larger cards and corner-attached edit chrome.
 * It does not specify pixel constants: these ratios are our measured adaptation
 * to Android density, not values extracted from Apple's implementation.
 */
public final class Ios26Design {
    public static final String REFERENCE =
        "https://support.apple.com/pt-pt/guide/iphone/iph59095ec58/26/ios/26";
    public static final int PORTRAIT_COLUMNS = 4;
    public static final int NONE = -1, MOVE = 0, RESIZE = 1, REMOVE = 2;
    public static final float HALO_DP = 12f, TOUCH_RADIUS_DP = 24f;

    private Ios26Design() { }

    public static final class Chrome {
        public final float width, height, radius;
        public final float removeX, removeY, resizeX, resizeY;
        private final float density;

        public Chrome(float width, float height, float density, int columns, int rows) {
            if (!Float.isFinite(width) || !Float.isFinite(height) || !Float.isFinite(density)
                    || density <= 0 || width < 48f * density || height < 48f * density
                    || columns < 1 || rows < 1)
                throw new IllegalArgumentException("Invalid measured control bounds");
            this.width = width; this.height = height; this.density = density;
            float small = Math.min(width, height);
            radius = columns == 1 || rows == 1 ? small / 2f : Math.min(32f * density, small * .22f);
            // Badges straddle the top-left corner. Resize is the lower-right
            // curved grip, including on a small one-cell circular control.
            removeX = removeY = 6f * density;
            resizeX = width - 6f * density; resizeY = height - 6f * density;
        }

        /** A 48dp circular touch region for each decoration. When the regions
         * overlap on a small control, the nearer center wins deterministically.
         * Coordinates are relative to the actual card, not its expanded View.
         */
        public int hit(float x, float y, boolean removable, boolean resizable) {
            if (!Float.isFinite(x) || !Float.isFinite(y)) return NONE;
            double a = removable ? distance(x, y, removeX, removeY) : Double.POSITIVE_INFINITY;
            double b = resizable ? distance(x, y, resizeX, resizeY) : Double.POSITIVE_INFINITY;
            double limit = TOUCH_RADIUS_DP * density;
            if (Math.min(a, b) <= limit * limit) return a <= b ? REMOVE : RESIZE;
            return contains(x, y) ? MOVE : NONE;
        }
        public boolean contains(float x, float y) {
            return x >= 0 && y >= 0 && x <= width && y <= height;
        }
        public double hitDistance(int role, float x, float y) {
            if (role == REMOVE) return distance(x, y, removeX, removeY);
            if (role == RESIZE) return distance(x, y, resizeX, resizeY);
            return Double.POSITIVE_INFINITY;
        }
        private static double distance(float x, float y, float cx, float cy) {
            double dx = (double)x - cx, dy = (double)y - cy;
            return dx * dx + dy * dy;
        }
    }
}
