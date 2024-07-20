module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [1:0] nextState;
reg [2:0] w_count; // Added register to count w input

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= nextState;
    end
end

always @(state, s, w) begin
    case (state)
        A: begin
            if (s == 1'b1) begin
                nextState <= B;
            end else begin
                nextState <= A;
            end
        end
        B: begin
            if (w == 1'b1) begin
                nextState <= C;
            end else begin
                nextState <= A;
            end
        end
        C: begin
            nextState <= A;
        end
    endcase
end

always @(posedge clk) begin
    if (state == C) begin
        w_count <= {w_count[1:0], w}; // Shift in w input to w_count register
        if (w_count == 3'b011) begin // Check if exactly two clock cycles have w input as 1
            z <= 1'b1;
        end else begin
            z <= 1'b0;
        end
    end else begin
        w_count <= 3'b000; // Reset w_count register when not in state C
        z <= 1'b0;
    end
end

endmodule
