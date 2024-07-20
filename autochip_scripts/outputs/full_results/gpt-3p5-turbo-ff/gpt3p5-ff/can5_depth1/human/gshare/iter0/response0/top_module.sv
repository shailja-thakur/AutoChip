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

    // Define internal signals
    reg [6:0] pc;
    reg [6:0] history;
    reg [6:0] index;
    reg [1:0] prediction;
    
    // Define counters and pattern history table
    reg [1:0] counters [0:127];
    
    // Initialize counters and history register
    initial begin
        for (int i = 0; i < 128; i = i + 1) begin
            counters[i] = 2'b01;
        end
        
        history = 7'b0000000;
    end
    
    // Clock edge detection
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            pc <= 7'b0000000;
            history <= 7'b0000000;
            index <= 7'b0000000;
            prediction <= 2'b00;
        end else if (predict_valid) begin
            pc <= predict_pc; 
            index <= pc ^ history; 
            prediction <= counters[index];
            predict_taken <= (prediction == 2'b11);
            predict_history <= history;
        end else if (train_valid && train_pc != predict_pc) begin
            index <= train_pc ^ train_history; 
            counters[index] <= (train_taken) ? 
                                ((counters[index] < 2'b11) ? counters[index] + 1 : counters[index]) :
                                ((counters[index] > 2'b00) ? counters[index] - 1 : counters[index]);
        end else if (train_valid && train_pc == predict_pc) begin
            index <= train_pc ^ train_history;
        end
    end
    
    // Branch history register update
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            history <= 7'b0000000;
        end else if (predict_valid) begin
            history <= {history[5:0], predict_taken};
        end else if (train_valid && train_pc != predict_pc) begin
            history <= {history[5:0], train_taken};
        end else if (train_valid && train_pc == predict_pc && train_mispredicted) begin
            history <= train_history;
        end
    end

endmodule
