module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [2:0] count;
wire [2:0] next_count;

parameter A = 2'b00; // Reset state
parameter B = 2'b01; // State when s = 1
parameter C = 2'b10; // State when w = 1 in exactly two of the next three clock cycles

assign next_count = count + 1;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= A;
        count <= 0;
        z <= 0;
    end else begin
        case (state)
            A: begin
                if (s) begin
                    state <= B;
                end
            end
            B: begin
                if (next_count == 3) begin
                    if (w == 2'b11) begin
                        state <= C;
                    end else begin
                        state <= B;
                    end
                end
            end
            C: begin
                if (next_count == 1) begin
                    if (w == 2'b11) begin
                        z <= 1;
                    end else begin
                        z <= 0;
                    end
                    state <= B;
                end else begin
                    state <= C;
                end
            end
        endcase
        count <= next_count;
    end
end

endmodule
