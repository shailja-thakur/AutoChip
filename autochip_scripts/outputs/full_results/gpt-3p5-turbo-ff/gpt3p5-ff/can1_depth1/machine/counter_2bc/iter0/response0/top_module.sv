module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Define the state machine states
    localparam STATE_0 = 2'b00;
    localparam STATE_1 = 2'b01;
    localparam STATE_2 = 2'b10;
    localparam STATE_3 = 2'b11;

    // Define the signals for state transitions
    reg [1:0] next_state;
    reg [1:0] current_state;

    // Assign initial state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_1;
        end else begin
            current_state <= next_state;
        end
    end

    // Determine the next state based on inputs
    always @(posedge clk) begin
        case (current_state)
            STATE_0: begin
                if (train_valid) begin
                    if (train_taken) begin
                        next_state <= STATE_1;
                    end else begin
                        next_state <= STATE_0;
                    end
                end else begin
                    next_state <= STATE_0;
                end
            end

            STATE_1: begin
                if (train_valid) begin
                    if (train_taken) begin
                        next_state <= STATE_2;
                    end else begin
                        next_state <= STATE_0;
                    end
                end else begin
                    next_state <= STATE_1;
                end
            end

            STATE_2: begin
                if (train_valid) begin
                    if (train_taken) begin
                        next_state <= STATE_3;
                    end else begin
                        next_state <= STATE_1;
                    end
                end else begin
                    next_state <= STATE_2;
                end
            end

            STATE_3: begin
                if (train_valid) begin
                    if (train_taken) begin
                        next_state <= STATE_3;
                    end else begin
                        next_state <= STATE_2;
                    end
                end else begin
                    next_state <= STATE_3;
                end
            end

            default: next_state <= STATE_1;
        endcase
    end

    // Assign the output state
    always @(posedge clk) begin
        state <= current_state;
    end

endmodule
