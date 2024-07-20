module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

// State registers
reg [1:0] current_state;
reg [1:0] next_state;

// Asynchronous reset
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= 2'b01;
    end else begin
        current_state <= next_state;
    end
end

// State transition logic
always @(train_valid, train_taken, current_state) begin
    case (current_state)
        2'b00: begin
            if (train_taken) begin
                next_state = 2'b01;
            end else begin
                next_state = 2'b00;
            end
        end
        2'b01: begin
            if (train_valid) begin
                next_state = (train_taken && (current_state < 2'b11)) ? current_state + 1 : current_state;
            end else begin
                next_state = (current_state > 2'b00) ? current_state - 1 : current_state;
            end
        end
        2'b10: begin
            if (train_taken && train_valid) begin
                next_state = 2'b11;
            end else begin
                next_state = 2'b10;
            end
        end
        2'b11: begin
            if (train_valid) begin
                next_state = (train_taken && (current_state < 2'b11)) ? current_state + 1 : current_state;
            end else begin
                next_state = (current_state > 2'b00) ? current_state - 1 : current_state;
            end
        end
    endcase
end

// Output assignment
assign state = current_state;

endmodule
