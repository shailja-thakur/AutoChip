module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    wire next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00;
        else
            state <= next_state;
    end

    assign next_state = (state == 2'b00 && in) ? 2'b01 :
                       (state == 2'b01 && in) ? 2'b01 :
                       (state == 2'b01 && !in) ? 2'b10 :
                       (state == 2'b10 && in) ? 2'b11 :
                       (state == 2'b10 && !in) ? 2'b00 :
                       (state == 2'b11 && in) ? 2'b01 :
                       (state == 2'b11 && !in) ? 2'b10 :
                       2'b00;

    assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
