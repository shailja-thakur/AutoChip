module top_module (
    input clk,
    input in,
    input reset,
    output out
);

// Define states
parameter B = 1'b0;
parameter A = 1'b1;

reg [1:0] state;
reg out;

always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        state <= B;
    end else begin
        case(state)
            B: begin
                if (in == 1'b0) begin
                    out <= 1'b1;
                    state <= A;
                end else begin
                    out <= 1'b1;
                    state <= B;
                end
            end
            A: begin
                if (in == 1'b0) begin
                    out <= 1'b0;
                    state <= B;
                end else begin
                    out <= 1'b0;
                    state <= A;
                end
            end
        endcase
    end
end

endmodule
