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

    reg [6:0] global_history;
    reg [1:0] pht [0:127];  // 128-entry table of 2-bit saturating counters
    integer i;

    // Two-bit saturating counter values for easier readability
    localparam STRONG_NOT_TAKEN = 2'b00;
    localparam WEAK_NOT_TAKEN   = 2'b01;
    localparam WEAK_TAKEN       = 2'b10;
    localparam STRONG_TAKEN     = 2'b11;

    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index   = train_pc ^ train_history;
    
    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                pht[i] <= WEAK_TAKEN;  // Initialize with weakly taken state
            end
        end else begin
            if (predict_valid) begin
                // Update global history register after prediction
                global_history <= {global_history[5:0], predict_taken};
            end

            if (train_valid) begin
                // Update the PHT entry
                case (pht[train_index])
                    STRONG_NOT_TAKEN: pht[train_index] <= train_taken ? WEAK_NOT_TAKEN : STRONG_NOT_TAKEN;
                    WEAK_NOT_TAKEN:   pht[train_index] <= train_taken ? WEAK_TAKEN     : STRONG_NOT_TAKEN;
                    WEAK_TAKEN:       pht[train_index] <= train_taken ? STRONG_TAKEN   : WEAK_NOT_TAKEN;
                    STRONG_TAKEN:     pht[train_index] <= train_taken ? STRONG_TAKEN   : WEAK_TAKEN;
                endcase
                
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end else if (!predict_valid) begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end
        end
    end

    always @(*) begin
        predict_taken = (pht[predict_index] == WEAK_TAKEN || pht[predict_index] == STRONG_TAKEN);
        predict_history = global_history;
    end

endmodule
