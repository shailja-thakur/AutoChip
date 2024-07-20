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

    // 128-entry table of two-bit saturating counters
    reg [1:0] PHT [127:0];
    // 7-bit global branch history register
    reg [6:0] global_history;

    // Initialize PHT and history register
    integer i;
    always @(posedge areset) begin
        global_history <= 7'b0;
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] <= 2'b01; // weakly not taken
        end
    end
    
    wire [6:0] index_predict = predict_pc ^ global_history;
    wire [6:0] index_train = train_pc ^ train_history;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end else begin
            // Update PHT for training
            if (train_valid) begin
                if (train_taken) begin
                    if (PHT[index_train] != 2'b11) begin
                        PHT[index_train] <= PHT[index_train] + 1;
                    end
                end else begin
                    if (PHT[index_train] != 2'b00) begin
                        PHT[index_train] <= PHT[index_train] - 1;
                    end
                end

                // Update history register if mispredicted
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end else begin
                    global_history <= {global_history[5:0], predict_valid ? predict_taken : global_history[6]};
                end
            end else if (predict_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end
    
    always @(*) begin
        // Make prediction based on PHT
        if (predict_valid) begin
            predict_history = global_history;
            case (PHT[index_predict])
                2'b00, 2'b01: predict_taken = 0; // weakly/strongly not taken
                2'b10, 2'b11: predict_taken = 1; // weakly/strongly taken
                default: predict_taken = 0;
            endcase
        end else begin
            predict_taken = 0;
            predict_history = global_history;
        end
    end

endmodule
