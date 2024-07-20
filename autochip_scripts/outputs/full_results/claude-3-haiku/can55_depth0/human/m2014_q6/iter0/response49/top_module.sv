module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// State definitions
localparam [2:0] A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

reg [2:0] current_state, next_state;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        A: begin
            if (w) begin
                next_state = A;
            end else begin
                next_state = B;
            end
        end
        B: begin
            if (w) begin
                next_state = D;
            end else begin
                next_state = C;
            end
        end
        C: begin
            if (w) begin
                next_state = D;
            end else begin
                next_state = E;
            end
        end
        D: begin
            if (w) begin
                next_state = A;
            end else begin
                next_state = F;
            end
        end
        E: begin
            if (w) begin
                next_state = D;
            end else begin
                next_state = E;
            end
        end
        F: begin
            if (w) begin
                next_state = D;
            end else begin
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
        E, F: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
