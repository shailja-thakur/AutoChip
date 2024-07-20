module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

// Define the state variables
reg [1:0] state;
parameter BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11;

// Define the state transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= BYTE1;
        out_bytes <= 0;
        done <= 0;
    end
    else begin
        case (state)
            BYTE1: begin
                out_bytes[7:0] <= in;
                if (in[2]) begin
                    state <= BYTE2;
                end
                else begin
                    state <= BYTE1;
                end
            end
            BYTE2: begin
                out_bytes[15:8] <= in;
                state <= BYTE3;
            end
            BYTE3: begin
                out_bytes[23:16] <= in;
                state <= DONE;
            end
            DONE: begin
                done <= 1;
                if (in[2]) begin
                    state <= BYTE1;
                    out_bytes <= 0;
                    done <= 0;
                end
                else begin
                    state <= DONE;
                end
            end
        endcase
    end
end

endmodule
