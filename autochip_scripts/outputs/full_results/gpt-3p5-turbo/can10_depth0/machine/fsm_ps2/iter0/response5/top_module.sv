module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    reg [1:0] state;
    reg done;
    wire bit3;

    assign bit3 = in[2];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;  // BYTE1 state
            done <= 0;
        end else begin
            case (state)
                2'b00: begin  // BYTE1 state
                    if (bit3) begin
                        state <= 2'b01;  // BYTE2 state
                    else
                        state <= 2'b00;  // Stay in BYTE1 state
                end
                2'b01: state <= 2'b10;  // BYTE2 state
                2'b10: state <= 2'b11;  // BYTE3 state
                2'b11: state <= bit3 ? 2'b01 : 2'b00;  // DONE state
            endcase
        end
    end

    assign done = (state == 2'b11);

endmodule
