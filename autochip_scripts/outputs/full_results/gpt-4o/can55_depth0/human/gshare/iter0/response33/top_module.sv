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
    reg [1:0] PHT [0:127]; // PHT with 128 2-bit counters
    reg [6:0] global_history;
    reg [6:0] next_global_history;

    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index = train_pc ^ train_history;

    assign predict_taken = PHT[predict_index][1];
    assign predict_history = global_history;

    // Initialize
    integer i;
    always @(posedge areset) begin
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] <= 2'b01; // initialize to weakly not taken
        end
        global_history <= 7'b0;
    end

    // Prediction
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end else if (predict_valid) begin
            global_history <= {global_history[5:0], predict_taken}; // update global history
        end
    end

    // Training
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end else if (train_valid) begin
            if (train_taken) begin
                if (PHT[train_index] != 2'b11) 
                    PHT[train_index] <= PHT[train_index] + 1;
            end else begin
                if (PHT[train_index] != 2'b00) 
                    PHT[train_index] <= PHT[train_index] - 1;
            end
            
            if (train_mispredicted) begin
                global_history <= train_history;
            end else begin
                global_history <= next_global_history;
            end
        end
    end

    always @(*) begin
        if (areset) begin
            next_global_history = 7'b0;
        end else if (train_valid && train_mispredicted) begin
            next_global_history = train_history;
        end else if (predict_valid) begin
            next_global_history = {global_history[5:0], predict_taken};
        end else begin
            next_global_history = global_history;
        end
    end

endmodule
