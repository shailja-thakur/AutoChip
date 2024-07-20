module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

// FSM states
localparam [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

// State register
reg [1:0] current_state, next_state;

always @(posedge clk) begin
    current_state <= next_state;
end

always @(*) begin
    // Next state logic
    case (current_state)
        S0: begin
            if (a == 0 && b == 0) begin
                next_state = S0;
            end
            else if (a == 0 && b == 1) begin
                next_state = S1;
            end
            else if (a == 1 && b == 0) begin
                next_state = S0;
            end
            else begin // a == 1 && b == 1
                next_state = S2;
            end
        end
        S1: begin
            if (a == 0 && b == 0) begin
                next_state = S0;
            end
            else if (a == 0 && b == 1) begin
                next_state = S1;
            end
            else if (a == 1 && b == 0) begin
                next_state = S1;
            end
            else begin // a == 1 && b == 1
                next_state = S0;
            end
        end
        S2: begin
            if (a == 0 && b == 0) begin
                next_state = S1;
            end
            else if (a == 0 && b == 1) begin
                next_state = S0;
            end
            else if (a == 1 && b == 0) begin
                next_state = S2;
            end
            else begin // a == 1 && b == 1
                next_state = S1;
            end
        end
        default: begin
            next_state = S0;
        end
    endcase

    // Output logic
    case (current_state)
        S0: begin
            q = 0;
            state = 0;
        end
        S1: begin
            q = 1;
            state = 0;
        end
        S2: begin
            q = 0;
            state = 1;
        end
        default: begin
            q = 0;
            state = 0;
        end
    endcase
end

endmodule
