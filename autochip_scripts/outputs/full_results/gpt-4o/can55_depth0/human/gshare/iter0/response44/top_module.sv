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

    reg [1:0] PHT [0:127]; // 128-entry table of 2-bit saturating counters
    reg [6:0] global_history; // 7-bit global branch history register

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Initialize to weakly taken
            end
        end else begin
            if (train_valid) begin
                // Update PHT entry for training
                if (train_taken) begin
                    if (PHT[(train_pc ^ train_history)] < 2'b11) begin
                        PHT[(train_pc ^ train_history)] <= PHT[(train_pc ^ train_history)] + 1;
                    end
                end else begin
                    if (PHT[(train_pc ^ train_history)] > 2'b00) begin
                        PHT[(train_pc ^ train_history)] <= PHT[(train_pc ^ train_history)] - 1;
                    end
                end

                // Update global history register
                if (train_mispredicted) begin
                    global_history <= {train_taken, train_history[6:1]};
                end else begin
                    global_history <= {train_taken, global_history[6:1]};
                end
            end else if (predict_valid) begin
                global_history <= {predict_taken, global_history[6:1]};
            end
        end
    end

    always @(*) begin
        if (areset) begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end else if (predict_valid) begin
            predict_history = global_history;
            case(PHT[(predict_pc ^ global_history)])
                2'b00, 2'b01: predict_taken = 1'b0;
                2'b10, 2'b11: predict_taken = 1'b1;
            endcase
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

endmodule
