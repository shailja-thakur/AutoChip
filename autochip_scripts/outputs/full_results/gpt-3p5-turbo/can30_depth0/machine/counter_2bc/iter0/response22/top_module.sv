module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the states
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;

    // Define the current state variable
    logic [1:0] current_state;

    // Assign initial state on reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_1;
        end else begin
            current_state <= current_state;
        end
    end

    // State transition logic
    always_comb begin
        case (current_state)
            STATE_0: begin
                if (train_valid && train_taken && (current_state < STATE_3)) begin
                    state <= STATE_2;
                end else begin
                    state <= STATE_0;
                end
            end
            STATE_1: begin
                if (train_valid && train_taken && (current_state < STATE_3)) begin
                    state <= STATE_2;
                end else if (train_valid && !train_taken && (current_state > STATE_0)) begin
                    state <= STATE_0;
                end else begin
                    state <= STATE_1;
                end
            end
            STATE_2: begin
                if (train_valid && train_taken && (current_state < STATE_3)) begin
                    state <= STATE_3;
                end else if (train_valid && !train_taken && (current_state > STATE_0)) begin
                    state <= STATE_1;
                end else begin
                    state <= STATE_2;
                end
            end
            STATE_3: begin
                if (train_valid && !train_taken && (current_state > STATE_0)) begin
                    state <= STATE_2;
                end else begin
                    state <= STATE_3;
                end
            end
            default: state <= STATE_1;
        endcase
    end
endmodule
