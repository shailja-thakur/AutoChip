module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states of the finite-state machine
parameter [1:0] IDLE = 2'b00, SEARCH = 2'b01, FOUND = 2'b11;

// Internal registers
reg [1:0] current_state, next_state;
reg [3:0] shift_register;

always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;
        start_shifting <= 1'b0;
        shift_register <= 4'b0000;
    end
    else begin
        current_state <= next_state;
        shift_register <= {shift_register[2:0], data};
    end
end

always @(*) begin
    case (current_state)
        IDLE: begin
            start_shifting = 1'b0;
            if (shift_register == 4'b1101) begin
                next_state = FOUND;
            end
            else begin
                next_state = SEARCH;
            end
        end
        SEARCH: begin
            start_shifting = 1'b0;
            if (shift_register == 4'b1101) begin
                next_state = FOUND;
            end
            else begin
                next_state = SEARCH;
            end
        end
        FOUND: begin
            start_shifting = 1'b1;
            next_state = FOUND;
        end
        default: begin
            start_shifting = 1'b0;
            next_state = IDLE;
        end
    endcase
end

endmodule
