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

    reg [6:0] GHR;
    reg [1:0] PHT [127:0];
    reg [6:0] predict_history_reg;
    reg predict_taken_reg;

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
                    GHR <= {GHR[5:0], train_taken};
            end else if (predict_valid) begin
                GHR <= {GHR[5:0], (PHT[predict_pc ^ GHR] >= 2'b10)};
            end
        end
    end

    always @* begin
        predict_history_reg = GHR;
        predict_taken_reg = (PHT[predict_pc ^ GHR] >= 2'b10) ? 1'b1 : 1'b0;
    end

    assign predict_taken = predict_taken_reg;
    assign predict_history = predict_history_reg;

endmodule
