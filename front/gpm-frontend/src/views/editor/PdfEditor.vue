<style scoped>
    .pdf-container{
        width: 100%;
        height: 100%;
        position: absolute;
        top:0;
        left:0;
        bottom:0;
        right:0;
    }
</style>
<template>

    <div style="height: 100%">
        <iframe :src="pdfSrc" width="100%" height="100%" frameborder="0"></iframe>
    </div>

</template>
<script>
    export default {
        data() {
            return {
                pdfSrc: null,
            }
        },
        computed: {
        },
        watch: {
        },
        methods: {
            async initData() {
                let selectedNode=this.$store.getters.getSelectedNode
                var dirPath = selectedNode.dirPath
                var fileName = selectedNode.fileName
                if(!fileName.endsWith(".pdf") && fileName.indexOf(" ")>0){
                    this.$Message.error("文件名中存在空格，无法转换，请重命名后尝试");
                    return;
                }

                let path=fileName.endsWith(".pdf")?"file/download":"file/transPdf";
                let token=localStorage.getItem("token")
                if(this.$store.getters.getEditorMode=="share"){
                    let shareKey=this.$store.getters.getShareData["ShareKey"]
                    path = encodeURIComponent(this.$globalConfig.goServer + path + "?fileDir=" + dirPath + "&fileName=" + fileName + (token ? "&token=" + token : "") + "&shareKey=" + shareKey, "utf-8");
                }else {
                    path = encodeURIComponent(this.$globalConfig.goServer + path + "?fileDir=" + dirPath + "&fileName=" + fileName + (token ? "&token=" + token : "") + "&Workspace=" + this.$store.getters.currentWorkspace, "utf-8");
                }
                this.pdfSrc='/pdf/web/viewer.html?file='+path
            }

        },
        mounted() {
            this.initData()
        }
    }
</script>
