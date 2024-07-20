module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// Define the states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter S10 = 3'b000;
parameter S11 = 3'b001;
parameter S20 = 3'b010;
parameter S21 = 3'b011;
parameter S22 = 3'b100;

// Define the state signals and next state signals
reg [1:0] state;
reg [2:0] nextState;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= nextState;
    end
end

always @* begin
    case (state)
        A: begin
            if (s) begin
                nextState = B;
            end
        end
        B: begin
            if (w) begin
                nextState = S11;
            end else begin
                nextState = S10;
            end
        end
        C: begin
            if (w) begin
                nextState = S11;
            end else begin
                nextState = S10;
            end
        end
        S10: begin
            if (w) begin
                nextState = S21;
            end else begin
                nextState = S20;
            end
        end
        S11: begin
            if (w) begin
                nextState = S22;
            end else begin
                nextState = S21;
            end
        end
        S20: begin
            nextState = B;
        end
        S21: begin
            if (w) begin
                nextState = C;
            end else begin
                nextState = B;
            end
        end
        S22: begin
            if (w) begin
                nextState = B;
            end else begin
                nextState = C;
            end
        end
    endcase
end

always @(posedge clk) begin
    case (state)
        B, C: begin
            z <= 1'b1;
        end
        default: begin
            z <= 1'b0;
        end
    endcase
end

endmodule
