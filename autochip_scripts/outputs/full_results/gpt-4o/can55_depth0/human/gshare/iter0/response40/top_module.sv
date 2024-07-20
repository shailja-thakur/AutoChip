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

    reg [6:0] global_history;
    reg [1:0] pht [0:127]; // 128 entries of 2-bit counters
    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index = train_pc ^ train_history;

    assign predict_history = global_history;
    
    // Saturating counter values
    localparam STRONG_NOT_TAKEN = 2'b00;
    localparam WEAK_NOT_TAKEN   = 2'b01;
    localparam WEAK_TAKEN       = 2'b10;
    localparam STRONG_TAKEN     = 2'b11;

    // Predict taken if counter value is 2 or 3
    assign predict_taken = predict_valid && (pht[predict_index] >= WEAK_TAKEN);

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                pht[i] <= WEAK_NOT_TAKEN; // Initialize counters to weak not taken
            end
        end else begin
            if (predict_valid && !train_valid) begin
                // Update branch history for new prediction
                global_history <= {global_history[5:0], predict_taken}; 
            end

            if (train_valid) begin
                // Update pattern history table
                case (train_taken)
                    1'b1: 
                        if (pht[train_index] != STRONG_TAKEN)
                            pht[train_index] <= pht[train_index] + 1;
                    1'b0: 
                        if (pht[train_index] != STRONG_NOT_TAKEN)
                            pht[train_index] <= pht[train_index] - 1;
                endcase

                // Recover history if there's a misprediction
                if (train_mispredicted)
                    global_history <= {train_history[5:0], train_taken};
                else
                    global_history <= {global_history[5:0], train_taken};
            end
        end
    end
    
endmodule
