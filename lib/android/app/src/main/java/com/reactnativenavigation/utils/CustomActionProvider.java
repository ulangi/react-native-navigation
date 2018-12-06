package com.reactnativenavigation.utils;

import android.content.Context;
import android.support.v4.view.ActionProvider;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.MenuItem;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

/*
 * Makes action menu item arrange similar to that of iOS
 */
public class CustomActionProvider extends ActionProvider {

    private MenuItem.OnMenuItemClickListener clickListener;
    private final MenuItem item;
    private int horizontalPadding;

    public CustomActionProvider(Context context, MenuItem item){
        super(context);
        this.item = item;
    }

    public void setHorizontalPadding(int horizontalPadding){
        this.horizontalPadding = horizontalPadding;
    }

    public void setOnClickMenuItemListener(MenuItem.OnMenuItemClickListener listener){
        this.clickListener = listener;
    }

    @Override
    public View onCreateActionView() {
        return this.onCreateActionView(item);
    }

    @Override
    public View onCreateActionView(MenuItem item) {
        TextView textView = new TextView(getContext());
        textView.setClickable(true);
        textView.setPadding(horizontalPadding, 0, horizontalPadding, 0);
        textView.setBackgroundResource(getRippleEffectResourceId());
        textView.setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT));
        textView.setGravity(Gravity.CENTER);
        textView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                clickListener.onMenuItemClick(item);
            }
        });
        if (item.getIcon() != null){
            textView.setCompoundDrawables(item.getIcon(), null, null, null);
        }
        else {
            textView.setText(item.getTitle());
            textView.setAllCaps(true);
        }
        return textView;
    }

    private int getRippleEffectResourceId(){
        TypedValue outValue = new TypedValue();
        getContext().getTheme().resolveAttribute(android.R.attr.actionBarItemBackground, outValue, true);
        return outValue.resourceId;
    }

}
