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

    // Two-bit saturating counter states
    localparam STRONGLY_NOT_TAKEN = 2'b00;
    localparam WEAKLY_NOT_TAKEN   = 2'b01;
    localparam WEAKLY_TAKEN       = 2'b10;
    localparam STRONGLY_TAKEN     = 2'b11;

    // Pattern History Table (PHT)
    reg [1:0] PHT [127:0];

    // Global branch history register
    reg [6:0] global_history;

    // Initialize PHT and global_history
    integer i;
    always @(posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= WEAKLY_NOT_TAKEN;
            end
        end
    end

    wire [6:0] predict_index = predict_pc ^ global_history;
    reg [6:0] next_history;

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            predict_history = global_history;
            case (PHT[predict_index])
                STRONGLY_NOT_TAKEN, WEAKLY_NOT_TAKEN: predict_taken = 1'b0;
                WEAKLY_TAKEN, STRONGLY_TAKEN: predict_taken = 1'b1;
            endcase
            next_history = {global_history[5:0], predict_taken};
        end else begin
            predict_taken = 1'b0;
            predict_history = global_history;
            next_history = global_history;
        end
    end

    // Training logic
    wire [6:0] train_index = train_pc ^ train_history;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end else if (train_valid) begin
            // Update the PHT entry
            case (PHT[train_index])
                STRONGLY_NOT_TAKEN: PHT[train_index] <= train_taken ? WEAKLY_NOT_TAKEN : STRONGLY_NOT_TAKEN;
                WEAKLY_NOT_TAKEN:   PHT[train_index] <= train_taken ? WEAKLY_TAKEN : STRONGLY_NOT_TAKEN;
                WEAKLY_TAKEN:       PHT[train_index] <= train_taken ? STRONGLY_TAKEN : WEAKLY_NOT_TAKEN;
                STRONGLY_TAKEN:     PHT[train_index] <= train_taken ? STRONGLY_TAKEN : WEAKLY_TAKEN;
            endcase

            // Update or recover the global branch history register
            if (train_mispredicted) begin
                global_history <= {train_history[5:0], train_taken};
            end else begin
                global_history <= {global_history[5:0], train_taken};
            end
        end else if (predict_valid) begin
            global_history <= next_history;
        end
    end

endmodule
