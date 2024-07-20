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
    reg [6:0] global_history; // Global 7-bit branch history register

    integer i;

    // Asynchronous reset
    always @(posedge areset) begin
        if (areset) begin
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b00; // Initialize PHT to weakly not taken
            end
            global_history <= 7'b0;
        end
    end

    wire [6:0] predict_index;
    wire [6:0] train_index;
    
    assign predict_index = predict_pc ^ global_history;
    assign train_index = train_pc ^ train_history;

    // Prediction logic
    always @(posedge clk) begin
        if (predict_valid) begin
            case (PHT[predict_index])
                2'b00, 2'b01: predict_taken <= 0;
                2'b10, 2'b11: predict_taken <= 1;
            endcase
            
            predict_history <= global_history;

            if (!train_valid) begin
                global_history <= {global_history[5:0], predict_taken}; // Update global history
            end
        end
    end

    // Training logic
    always @(posedge clk) begin
        if (train_valid) begin
            if (train_taken) begin
                if (PHT[train_index] != 2'b11) begin
                    PHT[train_index] <= PHT[train_index] + 1;
                end
            end else begin
                if (PHT[train_index] != 2'b00) begin
                    PHT[train_index] <= PHT[train_index] - 1;
                end
            end

            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken}; // Recover global history
            end else begin
                global_history <= {global_history[5:0], train_taken}; // Update global history
            end
        end
    end

endmodule
