module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Define the states
localparam A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

// Register to store the current state
reg [2:0] current_state, next_state;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= A;
    end
    else begin
        current_state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (current_state)
        A: begin
            if (w) begin
                next_state = A;
            end
            else begin
                next_state = B;
            end
        end
        B: begin
            if (w) begin
                next_state = D;
            end
            else begin
                next_state = C;
            end
        end
        C: begin
            if (w) begin
                next_state = D;
            end
            else begin
                next_state = E;
            end
        end
        D: begin
            if (w) begin
                next_state = A;
            end
            else begin
                next_state = F;
            end
        end
        E: begin
            if (w) begin
                next_state = D;
            end
            else begin
                next_state = E;
            end
        end
        F: begin
            if (w) begin
                next_state = D;
            end
            else begin
                next_state = C;
            end
        end
        default: begin
            next_state = A;
        end
    endcase
end

// Output logic
always @(current_state) begin
    case (current_state)
        E, F: begin
            z = 1'b1;
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
