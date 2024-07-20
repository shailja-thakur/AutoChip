module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    reg out;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00;
        else begin
            case (state)
                2'b00: if (in) state <= 2'b01; else state <= 2'b00;
                2'b01: if (in) state <= 2'b01; else state <= 2'b10;
                2'b10: if (in) state <= 2'b11; else state <= 2'b00;
                2'b11: if (in) state <= 2'b01; else state <= 2'b10;
                default: state <= 2'b00;
            endcase
        end
    end

    always @(state) begin
        if (state == 2'b11)
            out = 1'b1;
        else
            out = 1'b0;
    end

endmodule
