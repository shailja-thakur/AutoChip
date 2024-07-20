module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state;
    always @(posedge clk) begin
        if (reset)
            state <= 3'd0; // reset to state A
        else 
            case (state)
                3'b000: if (w == 1'b0) state <= 3'b001; else state <= 3'b000;
                3'b001: if (w == 1'b1) state <= 3'b010; else state <= 3'b011;
                3'b010: if (w == 1'b0) state <= 3'b011; else state <= 3'b001;
                3'b011: if (w == 1'b1) state <= 3'b000; else state <= 3'b100;
                3'b100: if (w == 1'b0) state <= 3'b011; else state <= 3'b100;
                3'b101: if (w == 1'b0) state <= 3'b010; else state <= 3'b011;
                default: state <= 3'b000;
            endcase
    end

    always @(state) begin
        if (state == 3'b101 || state == 3'b100)
            z <= 1'b1;
        else
            z <= 1'b0;
    end
endmodule
