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

    reg [1:0] PHT [127:0];       // Pattern History Table with 128 2-bit counters
    reg [6:0] global_history;    // 7-bit Global History Register
    
    // Define the states of the 2-bit saturating counter
    localparam STRONGLY_NOT_TAKEN = 2'b00;
    localparam WEAKLY_NOT_TAKEN   = 2'b01;
    localparam WEAKLY_TAKEN       = 2'b10;
    localparam STRONGLY_TAKEN     = 2'b11;

    // Asynchronous Reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= WEAKLY_NOT_TAKEN; // Initialize PHT with weakly not taken
            end
        end else if (train_valid) begin
            // Training the PHT
            reg [6:0] index = train_pc ^ train_history;
            if (train_taken) begin
                if (PHT[index] != STRONGLY_TAKEN)
                    PHT[index] <= PHT[index] + 1;
            end else begin
                if (PHT[index] != STRONGLY_NOT_TAKEN)
                    PHT[index] <= PHT[index] - 1;
            end

            // Update the global history based on training
            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end else begin
                global_history <= {global_history[5:0], train_taken};
            end
        end else if (predict_valid) begin
            // Predicting
            reg [6:0] index = predict_pc ^ global_history;
            reg [1:0] counter = PHT[index];
            predict_taken <= (counter == WEAKLY_TAKEN) | (counter == STRONGLY_TAKEN);
            predict_history <= global_history;

            // Update the global history based on prediction
            global_history <= {global_history[5:0], predict_taken};
        end
    end

endmodule
