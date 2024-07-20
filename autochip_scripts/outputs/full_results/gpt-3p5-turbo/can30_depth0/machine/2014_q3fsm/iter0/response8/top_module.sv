module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// State variables
reg [2:0] state, next_state;

// State values
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter S10 = 3'b011;
parameter S11 = 3'b100;
parameter S20 = 3'b101;
parameter S21 = 3'b110;
parameter S22 = 3'b111;

// Next_state logic
always @ (posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Output logic
always @ (*) begin
    case (state)
        A: begin
            if (s) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (w) begin
                next_state = S11;
            end else begin
                next_state = S10;
            end
        end
        C: begin
            if (w) begin
                next_state = S11;
            end else begin
                next_state = S10;
            end
        end
        S10: begin
            if (w) begin
                next_state = S21;
            end else begin
                next_state = S20;
            end
        end
        S11: begin
            if (w) begin
                next_state = S22;
            end else begin
                next_state = S21;
            end
        end
        S20: next_state = B;
        S21: begin
            if (w) begin
                next_state = C;
            end else begin
                next_state = B;
            end
        end
        S22: begin
            if (w) begin
                next_state = B;
            end else begin
                next_state = C;
            end
        end
        default: next_state = A;
    endcase
end

// Output assignment
always @ (posedge clk or posedge reset) begin
    if (reset) begin
        z <= 0;
    end else begin
        case (state)
            A, B, C: z <= 0;
            default: z <= 1;
        endcase
    end
end

endmodule
