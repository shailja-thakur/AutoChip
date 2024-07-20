module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // Reset to initial state
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b0;
    end else begin
        case (state)
            2'b00: begin
                if (s[3]) begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                end else if (s[1]) begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                    state <= 2'b01; // Transition to state 1
                end
            end
            2'b01: begin
                if (s[2]) begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                    state <= 2'b10; // Transition to state 2
                end else if (!s[1]) begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                    state <= 2'b00; // Transition to state 0
                end
            end
            2'b10: begin
                if (!s[1]) begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                    state <= 2'b00; // Transition to state 0
                end
            end
        endcase
    end
end

endmodule
