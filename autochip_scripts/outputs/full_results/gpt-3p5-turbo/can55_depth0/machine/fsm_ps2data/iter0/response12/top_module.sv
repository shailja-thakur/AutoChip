module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // initial state: BYTE1
        out_bytes <= 0;
        done <= 0;
    end else begin
        case (state)
            // BYTE1 state
            2'b00: begin
                if (in[2]) // transition to BYTE2
                    state <= 2'b01;
                else // transition to BYTE1
                    state <= 2'b00;
                out_bytes <= {out_bytes[15:0], in}; // shift in input
                done <= 0;
            end
            // BYTE2 state
            2'b01: begin
                if (in[2]) // transition to BYTE3
                    state <= 2'b10;
                else // transition to BYTE1
                    state <= 2'b00;
                out_bytes <= {out_bytes[15:0], in}; // shift in input
                done <= 0;
            end
            // BYTE3 state
            2'b10: begin
                // transition to DONE
                state <= 2'b11;
                out_bytes <= {out_bytes[15:0], in}; // shift in input
                done <= 0;
            end
            // DONE state
            2'b11: begin
                // transition to BYTE1
                state <= 2'b00;
                out_bytes <= {out_bytes[15:0], in}; // shift in input
                done <= 1;
            end
        endcase
    end
end

endmodule
