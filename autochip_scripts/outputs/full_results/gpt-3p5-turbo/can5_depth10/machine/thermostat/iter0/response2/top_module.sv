module top_module(
    input wire mode,
    input wire too_cold, 
    input wire too_hot,
    input wire fan_on,
    output wire heater,
    output wire aircon,
    output wire fan
);

    reg fan_ctrl;

    assign fan = fan_ctrl;

    always @(*) begin
        if (too_cold || too_hot || fan_on)
            fan_ctrl = 1;
        else
            fan_ctrl = 0;
    end

    always @(posedge mode or posedge too_cold) begin
        if (mode && too_cold)
            heater <= 1;
        else
            heater <= 0;
    end

    always @(posedge mode or posedge too_hot) begin
        if (!mode && too_hot)
            aircon <= 1;
        else
            aircon <= 0;
    end

endmodule
