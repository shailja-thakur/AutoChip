module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Define the states
localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;
localparam STATE_E = 3'b000;
localparam STATE_F = 3'b001;

// Register to store the current state
reg [2:0] current_state, next_state;

// State transition logic
always @(*) begin
    case (current_state)
        STATE_A: begin
            if (w) begin
                next_state = STATE_A;
            end else begin
                next_state = STATE_B;
            end
        end
        STATE_B: begin
            if (w) begin
                next_state = STATE_D;
            end else begin
                next_state = STATE_C;
            end
        end
        STATE_C: begin
            if (w) begin
                next_state = STATE_D;
            end else begin
                next_state = STATE_E;
            end
        end
        STATE_D: begin
            if (w) begin
                next_state = STATE_A;
            end else begin
                next_state = STATE_F;
            end
        end
        STATE_E: begin
            if (w) begin
                next_state = STATE_D;
            end else begin
                next_state = STATE_E;
            end
        end
        STATE_F: begin
            if (w) begin
                next_state = STATE_D;
            end else begin
                next_state = STATE_C;
            end
        end
        default: begin
            next_state = STATE_A;
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

// State register update
always @(posedge clk, posedge reset) begin
    if (reset) begin
        current_state <= STATE_A;
    end else begin
        current_state <= next_state;
    end
end

endmodule
