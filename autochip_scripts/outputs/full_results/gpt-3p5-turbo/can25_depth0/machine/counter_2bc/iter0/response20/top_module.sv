module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
// State register
reg [1:0] current_state, next_state;

// Initial state
initial begin
    current_state = 1;
end

// State transition logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= 1;
    end else if (train_valid) begin
        case (current_state)
            0: begin
                if (train_taken) begin
                    next_state <= 1;
                end else begin
                    next_state <= 0;
                end
            end
            1: begin
                if (train_taken) begin
                    next_state <= 2;
                end else begin
                    next_state <= 0;
                end
            end
            2: begin
                if (train_taken) begin
                    next_state <= 3;
                end else begin
                    next_state <= 1;
                end
            end
            3: begin
                if (train_taken) begin
                    next_state <= 3;
                end else begin
                    next_state <= 2;
                end
            end
            default: begin
                next_state <= 1;
            end
        endcase
    end else begin
        next_state <= current_state;
    end
end

// Assign next state to current state at the rising edge of the clock
always @(posedge clk) begin
    current_state <= next_state;
end

// Output state
assign state = current_state;

endmodule
