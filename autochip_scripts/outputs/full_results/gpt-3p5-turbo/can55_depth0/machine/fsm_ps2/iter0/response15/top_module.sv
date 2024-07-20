module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

// Define states
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// Declare state register
reg [1:0] state;

// Initialize state register
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
    end else begin
        case (state)
            BYTE1: begin
                if (in[2]) begin
                    state <= BYTE2;
                end else begin
                    state <= BYTE1;
                end
            end
            BYTE2: state <= BYTE3;
            BYTE3: state <= DONE;
            DONE: begin
                if (in[2]) begin
                    state <= BYTE2;
                end else begin
                    state <= BYTE1;
                end
            end
        endcase
    end
end

// Declare done output
assign done = (state == DONE);

endmodule
