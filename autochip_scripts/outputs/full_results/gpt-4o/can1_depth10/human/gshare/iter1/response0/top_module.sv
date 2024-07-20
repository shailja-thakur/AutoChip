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

    reg [1:0] PHT [0:127]; // 128 entry table of two-bit saturating counters
    reg [6:0] global_history;

    // Initialization for the pattern history table
    integer i;
    initial begin
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] = 2'b01; // Weakly not taken
        end
    end

    wire [6:0] predict_index;
    wire [6:0] train_index;

    // Calculate the indexes for prediction and training using xor
    assign predict_index = predict_pc ^ global_history;
    assign train_index = train_pc ^ train_history;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end else begin
            // Handle training
            if (train_valid) begin
                case (PHT[train_index])
                    2'b00: PHT[train_index] <= train_taken ? 2'b01 : 2'b00; // Strongly not taken
                    2'b01: PHT[train_index] <= train_taken ? 2'b10 : 2'b00; // Weakly not taken
                    2'b10: PHT[train_index] <= train_taken ? 2'b11 : 2'b01; // Weakly taken
                    2'b11: PHT[train_index] <= train_taken ? 2'b11 : 2'b10; // Strongly taken
                endcase

                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    always @(*) begin
        if (areset) begin
            predict_taken = 0;
            predict_history = 7'b0;
        end else if (predict_valid && !train_valid) begin
            predict_history = global_history;
            case (PHT[predict_index])
                2'b00, 2'b01: predict_taken = 0; // Not taken
                2'b10, 2'b11: predict_taken = 1; // Taken
            endcase
        end else begin
            predict_taken = 0;
            predict_history = 7'b0;
        end
    end

endmodule
