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
    // Parameters
    parameter TABLE_SIZE = 128;
    
    // Branch prediction table (PHT) 128 entries of 2-bit counters
    reg [1:0] PHT [0:TABLE_SIZE-1];

    // Branch history register (7-bit)
    reg [6:0] global_history;

    // Satutating counter update values
    localparam TAKEN_STRONG = 2'b11;
    localparam TAKEN_WEAK = 2'b10;
    localparam NOT_TAKEN_WEAK = 2'b01;
    localparam NOT_TAKEN_STRONG = 2'b00;

    // Asynchronous reset for resetting PHT and the global history register
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            global_history <= 7'b0;
            integer i;
            for (i = 0; i < TABLE_SIZE; i = i + 1) begin
                PHT[i] <= NOT_TAKEN_WEAK;
            end
        end
        else if(train_valid) begin
                global_history <= (train_mispredicted) ? train_history : {global_history[5:0], train_taken};
                // Compute index and update PHT
                integer idx;
                idx = train_pc ^ train_history;
                if(train_taken) begin
                    if(PHT[idx] < TAKEN_STRONG) 
                        PHT[idx] <= PHT[idx] + 1;
                end
                else begin
                    if(PHT[idx] > NOT_TAKEN_STRONG) 
                        PHT[idx] <= PHT[idx] - 1;
                end
        end
        else if(predict_valid) begin
            global_history <= {global_history[5:0], predict_taken};
        end
    end

    // Output logic for prediction
    always @( * ) begin
        integer predict_idx;
        predict_idx = predict_pc ^ global_history;
        predict_taken = (PHT[predict_idx] >= 2'b10) ? 1 : 0;
        predict_history = global_history;
    end

endmodule
