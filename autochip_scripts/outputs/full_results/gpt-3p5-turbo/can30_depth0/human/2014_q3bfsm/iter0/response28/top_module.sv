module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] present_state, next_state;

// State assignment
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;

// Next state logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        present_state <= S0;
    end else begin
        present_state <= next_state;
    end
end

// Output logic
always @(present_state, x) begin
    case (present_state)
        S0: begin
            if (x) begin
                next_state = S1;
            end else begin
                next_state = S0;
            end
            z = 0;
        end
        S1: begin
            if (x) begin
                next_state = S4;
            end else begin
                next_state = S1;
            end
            z = 0;
        end
        S2: begin
            if (x) begin
                next_state = S1;
            end else begin
                next_state = S2;
            end
            z = 0;
        end
        S3: begin
            if (x) begin
                next_state = S2;
            end else begin
                next_state = S1;
            end
            z = 1;
        end
        S4: begin
            if (x) begin
                next_state = S3;
            end else begin
                next_state = S4;
            end
            z = 1;
        end
        default: begin
            next_state = S0;
            z = 0;
        end
    endcase
end

endmodule
