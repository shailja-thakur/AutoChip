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

    reg [6:0] GHR;
    reg [1:0] PHT[127:0];
    
    integer i;
    initial begin
        GHR = 7'b0;
        for (i = 0; i < 128; i = i + 1)
            PHT[i] = 2'b01; // weakly not taken
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            GHR <= 7'b0;
            for (i = 0; i < 128; i = i + 1)
                PHT[i] <= 2'b01; // weakly not taken
        end else begin
            if (train_valid) begin
                integer index;
                index = train_pc ^ train_history;
                if (train_taken) begin
                    if (PHT[index] < 2'b11)
                        PHT[index] <= PHT[index] + 1;
                end else begin
                    if (PHT[index] > 2'b00)
                        PHT[index] <= PHT[index] - 1;
                end

                if (train_mispredicted) 
                    GHR <= {train_history[5:0], train_taken};
                else 
                    GHR <= {GHR[5:1], train_taken}; // Update GHR for correct prediction
            end else if (predict_valid) begin
                // Correct prediction will update GHR at next clock edge
                if (train_valid && train_mispredicted) begin
                    GHR <= {train_history[5:0], train_taken};
                end else begin
                    GHR <= {GHR[5:0], predict_taken};
                end
            end
        end
    end

    always @(*) begin
        if (areset) begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end else if (predict_valid) begin
            predict_history = GHR;
            predict_taken = (PHT[predict_pc ^ GHR] >= 2'b10) ? 1'b1 : 1'b0;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

endmodule
