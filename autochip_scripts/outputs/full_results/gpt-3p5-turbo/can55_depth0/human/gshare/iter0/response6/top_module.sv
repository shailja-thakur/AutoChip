module top_module(
    input clk,
    input areset, 

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken, 
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history, 
    input [6:0] train_pc
);

    reg [6:0] global_history_reg;
    reg [6:0] predict_index;
    reg [1:0] predict_counter;
    reg [6:0] train_index;
    reg [1:0] train_counter;

    // Initialize all registers with zeros
    initial begin
        global_history_reg = 7'b0;
        predict_index = 7'b0;
        predict_counter = 2'b0;
        train_index = 7'b0;
        train_counter = 2'b0;
    end

    // Predict branch direction
    always @(posedge clk) begin
        if (areset) begin
            // Reset all registers
            global_history_reg <= 7'b0;
            predict_index <= 7'b0;
            predict_counter <= 2'b0;
        end else if (predict_valid) begin
            // Calculate index using XOR operation
            predict_index <= predict_pc ^ global_history_reg;

            // Retrieve prediction from pattern history table
            case (predict_counter)
                2'b00: predict_taken <= 0;
                2'b01: predict_taken <= 0;
                2'b10: predict_taken <= 1;
                2'b11: predict_taken <= 1;
            end

            // Save branch history register for prediction
            predict_history <= global_history_reg;
        end
    end

    // Train branch predictor
    always @(posedge clk) begin
        if (areset) begin
            // Reset all registers
            train_index <= 7'b0;
            train_counter <= 2'b0;
        end else if (train_valid) begin
            // Calculate index using XOR operation
            train_index <= train_pc ^ train_history;

            // Update pattern history table
            if (train_taken) begin
                // Increment counter if branch is taken
                if (train_counter < 2'b11) begin
                    train_counter <= train_counter + 1;
                end
            end else begin
                // Decrement counter if branch is not taken
                if (train_counter > 2'b00) begin
                    train_counter <= train_counter - 1;
                end
            end

            // Update branch history register
            global_history_reg <= train_history;

            // Check for misprediction
            if (train_mispredicted) begin
                // Recover branch history register to state after mispredicting branch
                global_history_reg <= train_history;
            end
        end
    end

endmodule
