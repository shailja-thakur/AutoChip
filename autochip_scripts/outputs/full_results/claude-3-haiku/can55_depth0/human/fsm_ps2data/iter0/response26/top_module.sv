module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

// Define the states of the finite state machine
localparam SEARCH = 2'b00, RECEIVE1 = 2'b01, RECEIVE2 = 2'b10, RECEIVE3 = 2'b11;

// Internal registers
reg [1:0] state;
reg [7:0] byte1, byte2, byte3;
reg [1:0] byte_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= SEARCH;
        byte_count <= 0;
        done <= 0;
    end else begin
        case (state)
            SEARCH: begin
                if (in[3]) begin
                    state <= RECEIVE1;
                    byte1 <= in;
                    byte_count <= 1;
                end
            end
            RECEIVE1: begin
                byte2 <= in;
                state <= RECEIVE2;
                byte_count <= 2;
            end
            RECEIVE2: begin
                byte3 <= in;
                state <= RECEIVE3;
                byte_count <= 3;
            end
            RECEIVE3: begin
                out_bytes <= {byte1, byte2, byte3};
                done <= 1;
                state <= SEARCH;
                byte_count <= 0;
            end
        endcase
    end
end

endmodule
