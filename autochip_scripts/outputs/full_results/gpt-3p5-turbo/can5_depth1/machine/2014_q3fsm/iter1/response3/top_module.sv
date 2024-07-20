module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// Define the states
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter S10 = 3;
parameter S11 = 4;
parameter S20 = 5;
parameter S21 = 6;
parameter S22 = 7;

// Define the current and next state variables
reg [2:0] state;
reg [2:0] next_state;

// Define the state transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Define the next state logic
always @* begin
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
        S20: begin
            next_state = B;
        end
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
        default: begin
            next_state = next_state;
        end
    endcase
end

// Define the output logic
always @(posedge clk) begin
    if (reset) begin
        z <= 0;
    end else begin
        case (state)
            A: begin
                z <= 0;
            end
            B: begin
                z <= 0;
            end
            C: begin
                z <= 1;
            end
            default: begin
                z <= 0;
            end
        endcase
    end
end

endmodule
