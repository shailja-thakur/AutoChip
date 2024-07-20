module top_module(
    input clk,
    input areset, 

    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken, 
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history, 
    input [6:0] train_pc
);
    reg [1:0] PHT[127:0]; // 2-bit saturating counters
    reg [6:0] global_history; // 7-bit Global History Register
    integer i;

    // Define the 2-bit saturating counters state values
    localparam STRONGLY_NOT_TAKEN = 2'b00;
    localparam WEAKLY_NOT_TAKEN   = 2'b01;
    localparam WEAKLY_TAKEN       = 2'b10;
    localparam STRONGLY_TAKEN     = 2'b11;

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= WEAKLY_NOT_TAKEN; // Initialize PHT to weakly not taken
            end
        end else begin
            // Training logic
            if (train_valid) begin
                // Hash the pc and history
                integer index = train_pc ^ train_history;

                // Update the PHT with the actual branch outcome
                case (PHT[index])
                    STRONGLY_NOT_TAKEN: PHT[index] <= train_taken ? WEAKLY_NOT_TAKEN : STRONGLY_NOT_TAKEN;
                    WEAKLY_NOT_TAKEN:   PHT[index] <= train_taken ? WEAKLY_TAKEN : STRONGLY_NOT_TAKEN;
                    WEAKLY_TAKEN:       PHT[index] <= train_taken ? STRONGLY_TAKEN : WEAKLY_NOT_TAKEN;
                    STRONGLY_TAKEN:     PHT[index] <= train_taken ? STRONGLY_TAKEN : WEAKLY_TAKEN;
                endcase

                // Update the global history depending on misprediction
                if (train_mispredicted)
                    global_history <= {global_history[5:0], train_taken};
                else
                    global_history <= {global_history[5:0], predict_taken};
            end

            // Prediction logic
            if (predict_valid) begin
                // Hash the pc and history
                integer predict_index = predict_pc ^ global_history;
                predict_history <= global_history;

                case (PHT[predict_index])
                    STRONGLY_NOT_TAKEN,
                    WEAKLY_NOT_TAKEN:   predict_taken <= 0; // Not taken
                    WEAKLY_TAKEN,
                    STRONGLY_TAKEN:     predict_taken <= 1; // Taken
                endcase

                // Update the global history based on predicted outcome
                if (!train_valid)
                    global_history <= {global_history[5:0], predict_taken};
            end
        end
    end
endmodule
