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

    reg [1:0] pht [0:127];  // Pattern History Table: 128 entries of 2-bit saturating counters
    reg [6:0] global_history; // 7-bit Global History Register

    wire [6:0] predict_index;
    wire [6:0] train_index;
    reg [1:0] train_counter;

    // XOR for hashing PC and Global History into index
    assign predict_index = predict_pc ^ global_history;
    assign train_index = train_pc ^ train_history;

    // Asynchronous Reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                pht[i] <= 2'b01;  // Initialize with "weakly not taken"
            end
        end
        else begin
            if (train_valid) begin
                // Update the PHT entry based on actual outcome
                train_counter = pht[train_index];
                if (train_taken) begin
                    if (train_counter < 2'b11)
                        pht[train_index] <= train_counter + 1;
                end else begin
                    if (train_counter > 2'b00)
                        pht[train_index] <= train_counter - 1;
                end
                // Update or recover global history
                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update global history for predicted branch
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    // Make prediction
    always @(*) begin
        if (predict_valid) begin
            predict_history = global_history;
            predict_taken = (pht[predict_index] >= 2'b10);  // "Taken" if counter is 2 or 3
        end else begin
            predict_taken = 0;
            predict_history = 7'b0;
        end
    end

endmodule
