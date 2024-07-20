module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

// Define the states of the FSM
localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

// Register to hold the current state
reg [1:0] current_state, next_state;

// Register to keep track of the x input sequence
reg [1:0] x_seq;

// Register to keep track of the number of clock cycles since y became 1
reg [1:0] y_count;

// State transition logic
always @(posedge clk, negedge resetn) begin
    if (!resetn) begin
        current_state <= STATE_A;
        x_seq <= 0;
        y_count <= 0;
    end
    else begin
        current_state <= next_state;
        case (current_state)
            STATE_A: begin
                f <= 0;
                g <= 0;
                x_seq <= 0;
                y_count <= 0;
            end
            STATE_B: begin
                f <= 1;
                g <= 0;
                x_seq <= {x_seq[0], x};
                y_count <= 0;
            end
            STATE_C: begin
                f <= 0;
                if (y_count < 2)
                    y_count <= y_count + 1;
                else
                    g <= 0;
            end
            STATE_D: begin
                f <= 0;
                g <= 1;
            end
        endcase
    end
end

// Next state logic
always @(*) begin
    case (current_state)
        STATE_A: begin
            if (resetn)
                next_state = STATE_B;
            else
                next_state = STATE_A;
        end
        STATE_B: begin
            if (x_seq == 2'b101)
                next_state = STATE_C;
            else
                next_state = STATE_B;
        end
        STATE_C: begin
            if (y == 1)
                next_state = STATE_D;
            else
                next_state = STATE_C;
        end
        STATE_D: begin
            next_state = STATE_D;
        end
    endcase
end

endmodule
