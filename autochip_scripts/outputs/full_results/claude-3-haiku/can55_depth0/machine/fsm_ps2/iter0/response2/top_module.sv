module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

// Define the states of the state machine
localparam BYTE1 = 2'b00,
           BYTE2 = 2'b01,
           BYTE3 = 2'b10,
           DONE  = 2'b11;

// Declare the state register
reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        done <= 1'b0;
    end
    else begin
        case (state)
            BYTE1: begin
                if (in[2]) begin
                    state <= BYTE2;
                end
                else begin
                    state <= BYTE1;
                end
            end
            BYTE2: begin
                state <= BYTE3;
            end
            BYTE3: begin
                state <= DONE;
            end
            DONE: begin
                if (in[2]) begin
                    state <= BYTE2;
                end
                else begin
                    state <= BYTE1;
                end
                done <= 1'b1;
            end
        endcase
    end
end

endmodule
