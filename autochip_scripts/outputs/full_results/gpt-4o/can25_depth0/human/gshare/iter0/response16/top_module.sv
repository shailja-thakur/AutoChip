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
    reg [1:0] PHT [127:0]; // 128-entry table of 2-bit saturating counters
    reg [6:0] global_history;

    // Function to compute the saturating increment
    function [1:0] sat_inc;
        input [1:0] cnt;
        begin
            if (cnt == 2'b11)
                sat_inc = cnt;
            else
                sat_inc = cnt + 1;
        end
    endfunction

    // Function to compute the saturating decrement
    function [1:0] sat_dec;
        input [1:0] cnt;
        begin
            if (cnt == 2'b00)
                sat_dec = cnt;
            else
                sat_dec = cnt - 1;
        end
    endfunction

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b10; // Initialize counters to weakly taken state
            end
            global_history <= 7'b0;
        end else begin
            // Training mechanism
            if (train_valid) begin
                // Compute the index for the PHT
                integer index;
                index = train_pc ^ train_history;

                // Update the PHT based on the actual outcome
                if (train_taken) begin
                    PHT[index] <= sat_inc(PHT[index]);
                end else begin
                    PHT[index] <= sat_dec(PHT[index]);
                end

                // Recover the branch history register if a misprediction occurred
                if (train_mispredicted) begin
                    global_history <= {train_history, train_taken};
                end
            end

            // Global history register update for prediction
            if (predict_valid && !train_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end 
        end
    end

    // Prediction mechanism
    always @(*) begin
        // Compute the index for the PHT
        integer index;
        index = predict_pc ^ global_history;

        // Predict taken if counter is in upper half
        predict_taken = PHT[index][1];
        predict_history = global_history;
    end
endmodule
