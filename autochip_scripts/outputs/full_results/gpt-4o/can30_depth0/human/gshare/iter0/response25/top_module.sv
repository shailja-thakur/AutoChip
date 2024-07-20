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

    reg [1:0] PHT [0:127]; // 128-entry table of two-bit saturating counters
    reg [6:0] global_history; // 7-bit global branch history register

    integer i;

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Initialize all counters to weakly not taken
            end
        end
        else begin
            if (train_valid) begin
                // Training logic
                integer index;
                index = train_pc ^ train_history;

                // Update the PHT entry
                if (train_taken) begin
                    if (PHT[index] < 2'b11) begin
                        PHT[index] <= PHT[index] + 2'b01;
                    end
                end
                else begin
                    if (PHT[index] > 2'b00) begin
                        PHT[index] <= PHT[index] - 2'b01;
                    end
                end

                // Recover or update global history
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end
            else if (predict_valid) begin
                // Update global history for prediction
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    // Prediction logic
    always @(*) begin
        integer index;
        index = predict_pc ^ global_history;
        predict_taken = PHT[index][1]; // MSB of the counter indicates the prediction
        predict_history = global_history;
    end

endmodule
