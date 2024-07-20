module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Define the states of the state machine
localparam [2:0] STATE_A = 3'd0,
                 STATE_B = 3'd1,
                 STATE_C = 3'd2,
                 STATE_D = 3'd3,
                 STATE_E = 3'd4,
                 STATE_F = 3'd5;

// Register to hold the current state
reg [2:0] current_state;

// Next state logic
always @(*) begin
    case (current_state)
        STATE_A: begin
            if (w) begin
                current_state = STATE_A;
            end else begin
                current_state = STATE_B;
            end
        end
        STATE_B: begin
            if (w) begin
                current_state = STATE_D;
            end else begin
                current_state = STATE_C;
            end
        end
        STATE_C: begin
            if (w) begin
                current_state = STATE_D;
            end else begin
                current_state = STATE_E;
            end
        end
        STATE_D: begin
            if (w) begin
                current_state = STATE_A;
            end else begin
                current_state = STATE_F;
            end
        end
        STATE_E: begin
            if (w) begin
                current_state = STATE_D;
            end else begin
                current_state = STATE_E;
            end
        end
        STATE_F: begin
            if (w) begin
                current_state = STATE_D;
            end else begin
                current_state = STATE_C;
            end
        end
        default: begin
            current_state = STATE_A;
        end
    endcase
end

// Output logic
always @(*) begin
    case (current_state)
        STATE_E, STATE_F: begin
            z = 1'b1;
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

// State update logic
always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_A;
    end else begin
        current_state <= current_state;
    end
end

endmodule
